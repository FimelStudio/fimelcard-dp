"""在原版 Minecraft GameTest 中运行 UNO 行为测试，不修改存档或生产 data。

默认使用本机 PCL 的 26.2 客户端与 Java 25。也可显式指定：
python tools/test_uno.py --minecraft-root D:/PCL2/MinecraftPcl \
    --version 26.2-Fabric_0.19.3 --java C:/path/to/java.exe

测试将当前数据包复制到新建的临时世界，注入 uno_test 测试命名空间。
真实执行 UNO 函数，以实体记分项及日志断言行为；没有源码字符串断言。
marker 参与者用于测试后台逻辑，不能替代真人客户端交互及美术验收。
"""

from __future__ import annotations

import argparse
import json
import re
import shutil
import subprocess
import sys
import tempfile
import time
from pathlib import Path


PACK = Path(__file__).resolve().parents[1]
A = '@e[type=minecraft:marker,tag=ut.controller,scores={ct_id=101},limit=1]'
B = '@e[type=minecraft:marker,tag=ut.controller,scores={ct_id=202},limit=1]'


def person(seat: int, table: int = 101) -> str:
    return f'@e[type=minecraft:marker,tag=un.player,scores={{ct_id={table},un_seat={seat}}},limit=1]'


def card(idx: int, table: int = 101) -> str:
    return f'@e[type=minecraft:marker,tag=un.card,scores={{ct_id={table},un_idx={idx}}},limit=1]'


class Fixtures:
    def __init__(self) -> None:
        self.files: dict[str, str] = {}
        self.cases: list[str] = []
        self.expected: list[str] = []

    def file(self, name: str, commands: list[str] | str) -> None:
        self.files[name] = ('\n'.join(commands) if isinstance(commands, list) else commands).strip() + '\n'

    def case(self, name: str, commands: list[str]) -> None:
        self.cases.append(name)
        self.file('case/' + name, commands)

    def check(self, condition: str, name: str) -> list[str]:
        assert name not in self.expected, name
        self.expected.append(name)
        return [f'execute if {condition} run function uno_test:pass {{name:"{name}"}}',
                f'execute unless {condition} run function uno_test:fail {{name:"{name}"}}']

    def score(self, target: str, objective: str, value: int | str, name: str) -> list[str]:
        return self.check(f'score {target} {objective} matches {value}', name)

    def count(self, selector: str, value: int, name: str) -> list[str]:
        return ['scoreboard players set #actual ut 0',
                f'execute as {selector} run scoreboard players add #actual ut 1'] + self.score('#actual', 'ut', value, name)

    def queue(self, value: int, name: str, table: int = 101) -> list[str]:
        target = A if table == 101 else B
        return ['scoreboard players set #actual ut 0',
                f'execute store result score #actual ut run data get entity {target} data.uno.deal_queue'] + self.score('#actual', 'ut', value, name)

    @staticmethod
    def seat(seat: int, x: float, z: float, table: int = 101, y: float = 64.32) -> list[str]:
        return [f'execute positioned {x} {y} {z} summon minecraft:interaction run function uno_test:seat {{table:{table},seat:{seat}}}']

    @staticmethod
    def table(table: int = 101, seats: tuple[int, ...] = (1, 6, 8), create_deck: bool = True) -> list[str]:
        x = 0 if table == 101 else 24
        result = [f'execute positioned {x:.1f} 64 0.0 summon minecraft:marker run function uno_test:controller {{table:{table},size:{len(seats)}}}']
        result += [f'execute positioned {x:.1f} 64 0.0 summon minecraft:marker run function uno_test:person {{table:{table},seat:{seat}}}' for seat in seats]
        target = A if table == 101 else B
        result += [f'execute as {target} at @s run function uno:system/context']
        if create_deck:
            result += [f'execute as {target} at @s run function uno:deck/create']
        return result

    def setup(self, seats: tuple[int, ...] = (1, 6, 8)) -> list[str]:
        return ['function uno_test:reset'] + self.table(seats=seats)

    @staticmethod
    def hand(seat: int, indices: list[int], table: int = 101) -> list[str]:
        return [f'scoreboard players set {card(idx, table)} un_owner {seat}' for idx in indices] + [f'scoreboard players set {person(seat, table)} un_count {len(indices)}']

    @staticmethod
    def top(idx: int, table: int = 101) -> list[str]:
        target = A if table == 101 else B
        return [f'scoreboard players set {card(idx, table)} un_owner -1',
                f'scoreboard players set {target} un_top {idx}',
                f'scoreboard players operation {target} un_color = {card(idx, table)} un_color',
                f'scoreboard players operation {target} un_value = {card(idx, table)} un_value']

    @staticmethod
    def actor(seat: int, table: int = 101) -> list[str]:
        return ['tag @e[tag=un.actor] remove un.actor', f'tag {person(seat, table)} add un.actor']

    def play(self, seat: int, kind: int, say: int = 1, colour: int = 1, table: int = 101) -> list[str]:
        target = A if table == 101 else B
        return self.actor(seat, table) + [f'scoreboard players set {person(seat, table)} un_pick {kind}',
                f'scoreboard players set #say un_ctx {say}', f'scoreboard players set #color un_ctx {colour}',
                f'execute as {target} at @s run function uno:action/play']

    def action(self, name: str, seat: int = 1) -> list[str]:
        return self.actor(seat) + [f'execute as {A} at @s run function uno:action/{name}']

    def normal_hands(self, first: list[int], seats: tuple[int, ...] = (1, 6, 8)) -> list[str]:
        result = self.hand(1, first)
        if 6 in seats:
            result += self.hand(6, [51, 77])  # green zero, blue one
        if 8 in seats:
            result += self.hand(8, [52, 78])
        return result

    @staticmethod
    def keep_deck(*indices: int) -> list[str]:
        result = ['tag @e[tag=ut.keep] remove ut.keep']
        result += [f'tag {card(idx)} add ut.keep' for idx in indices]
        return result + ['kill @e[type=minecraft:marker,tag=un.card,tag=!ut.keep,scores={ct_id=101,un_owner=0}]']

    def build(self) -> None:
        self.file('pass', ['scoreboard players add #passed ut 1', '$say UNO_TEST_PASS $(name)'])
        self.file('fail', ['scoreboard players add #failed ut 1', '$say UNO_TEST_FAIL $(name)'])
        self.file('reset', '''
kill @e[tag=ut.fixture]
kill @e[tag=un.card]
kill @e[tag=un.visual]
kill @e[tag=ct.deal_box]
kill @e[tag=ct.deal_card]
kill @e[tag=ct.visual_only]
kill @e[tag=ct.menu]
kill @e[tag=ct.vote]
kill @e[tag=ct.part]
kill @e[tag=un.firework]
tag @e[tag=un.actor] remove un.actor
scoreboard players set #ui_opened ut 0
scoreboard players set #ui_played un_ctx 0
scoreboard players set #say un_ctx 1
scoreboard players set #color un_ctx 1
''')
        self.file('controller', '''
tag @s add ut.fixture
tag @s add ut.controller
tag @s add un.controller
$scoreboard players set @s ct_id $(table)
scoreboard players set @s ct_game 11
scoreboard players set @s ct_capacity 8
scoreboard players set @s ct_state 1
$scoreboard players set @s ct_joined $(size)
$scoreboard players set @s un_size $(size)
scoreboard players set @s un_state 2
scoreboard players set @s un_turn 1
scoreboard players set @s un_dir 1
scoreboard players set @s un_color 0
scoreboard players set @s un_value 0
scoreboard players set @s un_top 1
scoreboard players set @s un_epoch 1
scoreboard players set @s un_round 1
scoreboard players set @s un_challenge 1
scoreboard players set @s un_auto 0
scoreboard players set @s un_window 60
scoreboard players set @s un_drew 0
scoreboard players set @s un_drawn 0
scoreboard players set @s un_winner 0
scoreboard players set @s un_clock -10000
scoreboard players set @s un_timer 0
scoreboard players set @s un_pending 0
scoreboard players set @s un_mode 0
scoreboard players set @s un_rounds 3
scoreboard players set @s un_target 500
scoreboard players set @s un_matchend 0
scoreboard players set @s un_anim_wait 0
''')
        self.file('person', '''
tag @s add ut.fixture
tag @s add un.player
tag @s add ct.player
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s un_table $(table)
$scoreboard players set @s un_seat $(seat)
$scoreboard players set @s ct_seat $(seat)
scoreboard players set @s un_count 0
scoreboard players set @s un_score 0
scoreboard players set @s un_pick -1
''')
        self.file('seat', '''
tag @s add ut.fixture
tag @s add ct.seat
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_seat $(seat)
''')
        self.file('queue_check', '''
$execute unless entity @e[type=minecraft:marker,tag=un.card,scores={ct_id=101,un_idx=$(idx),un_owner=$(seat)}] run scoreboard players add #queue_bad ut 1
$scoreboard players add #queued_seat_$(seat) ut 1
''')

        # Dialog不会解析selector；实际执行set_name，把本行执行者的名字固化为组件。
        commands = self.setup((1, 8)) + self.table(202, (1, 8), create_deck=False)
        commands += [f'data merge entity {person(1)} {{CustomName:{{text:"UNO_Name_A"}}}}',
                     f'data merge entity {person(8,202)} {{CustomName:{{text:"测试玩家B"}}}}',
                     f'scoreboard players set {person(1)} un_count 7', f'scoreboard players set {person(1)} un_score 20',
                     f'execute as {A} at @s run function uno:system/context',
                     'data modify storage uno:ui players set value {text:"",extra:[]}',
                     f'execute as {person(1)} at @s run function uno:ui/player_line']
        commands += self.check('data storage uno:ui players.extra[0].extra[1].extra[{text:"UNO_Name_A"}]', 'dialog_name_resolved_to_text')
        commands += self.check('data storage uno:ui players.extra[0].extra[{text:"1号位 "}]', 'dialog_name_preserves_seat')
        commands += self.check('data storage uno:ui players.extra[0].extra[{text:" · 7张 · 20分 ▶\\n"}]', 'dialog_name_preserves_count_score_turn')
        commands += ['execute store success score #name_selector ut run data get storage uno:ui players.extra[0].extra[1].extra[0].selector']
        commands += self.score('#name_selector','ut',0,'dialog_name_has_no_selector')
        commands += [f'execute as {B} at @s run function uno:system/context', f'execute as {person(8,202)} at @s run function uno:ui/player_line']
        commands += self.check('data storage uno:ui players.extra[1].extra[1].extra[{text:"测试玩家B"}]', 'dialog_name_unicode_and_other_table')
        commands += self.check('data storage uno:ui players.extra[0].extra[1].extra[{text:"UNO_Name_A"}]', 'dialog_name_previous_row_stays_static')
        commands += self.count('@e[type=minecraft:item_display,tag=un.name_resolver]',0,'dialog_name_resolver_cleaned')
        self.case('dialog_names',commands)

        commands = self.setup() + self.normal_hands([2,14,3])
        commands += [f'scoreboard players set {person(1)} un_pick -1', 'scoreboard players set #ui_action un_ctx 101',
                     f'execute as {person(1)} at @s run function uno:input/select']
        commands += self.score(person(1),'un_pick',1,'selection_first_click_selects')
        commands += ['scoreboard players set #ui_action un_ctx 101', f'execute as {person(1)} at @s run function uno:input/select']
        commands += self.score(person(1),'un_pick',-1,'selection_second_click_cancels')
        commands += ['scoreboard players set #ui_action un_ctx 101',f'execute as {person(1)} at @s run function uno:input/select',
                     'scoreboard players set #ui_action un_ctx 102',f'execute as {person(1)} at @s run function uno:input/select']
        commands += self.score(person(1),'un_pick',2,'selection_other_card_transfers')
        commands += ['tag @e[tag=un.uihand] remove un.uihand', f'tag {card(2)} add un.uihand', f'tag {card(14)} add un.uihand', f'tag {card(3)} add un.uihand',
                     'scoreboard players set #ui_base un_ctx 1000','scoreboard players set #ui_col un_ctx 0',
                     'data modify storage uno:ui grid set value {text:"",extra:[]}',
                     f'execute as {person(1)} run function uno:ui/append {{id:2,glyph:"\ue602",name:"红2"}}']
        commands += self.check('data storage uno:ui grid.extra[0].extra[{font:"card:uno/dialog_selected"}]','selection_selected_card_glows')
        commands += [f'execute as {person(1)} run function uno:ui/append {{id:1,glyph:"\ue601",name:"红1"}}']
        commands += self.check('data storage uno:ui grid.extra[1].extra[{font:"card:uno/dialog"}]','selection_old_card_not_glowing')
        commands += self.check('data storage uno:ui grid.extra[1].extra[{text:"×2  "}]','selection_keeps_duplicate_count')
        commands += self.score(person(1),'un_count',3,'selection_never_plays_or_consumes')
        self.case('selection_toggle_glow',commands)

        self.file('dialogs',(PACK / 'tools/test_uno_dialogs.mcfunction').read_text(encoding='utf-8'))
        self.case('dialog_codecs',['function uno_test:dialogs'])

        # 原样执行输入路由；只在临时副本观测ui/open调用次数，验证真正不重开。
        for label, hand, top, pick, action_code, selected_colour, should_close in [
            ('ordinary', [2,3], 1, 1, 1001, -1, True),
            ('wild', [101,9], 1, 52, 1203, 52, True),
            ('illegal', [57,9], 6, 32, 1001, -1, False),
        ]:
            commands = self.setup() + self.normal_hands(hand) + self.top(top)
            commands += [f'tag {A} add ct.controller', f'scoreboard players set {person(1)} un_pick {pick}',
                         f'scoreboard players set {person(1)} un_colorpick {selected_colour}',
                         f'scoreboard players set {person(1)} un_seen 1',f'scoreboard players set {person(1)} un_action {action_code}',
                         'data remove storage uno:message play', f'execute as {person(1)} at @s run function uno:input/submit']
            commands += self.score('#ui_played','un_ctx',1 if should_close else 0,'submit_'+label+'_commit_flag')
            commands += self.score('#ui_opened','ut',0 if should_close else 1,'submit_'+label+'_dialog_reopen_count')
            if label=='ordinary':
                commands += self.check('data storage uno:message play.card{text:"红1"}','submit_chat_names_actual_card')
            elif label=='wild':
                commands += self.check('data storage uno:message play.card{text:"变色"}','submit_chat_names_wild')
                commands += self.check('data storage uno:message play.chosen{text:"（改为蓝色）"}','submit_chat_names_chosen_colour')
            else:
                commands += ['execute store success score #chat_written ut run data get storage uno:message play']
                commands += self.score('#chat_written','ut',0,'submit_illegal_never_announced')
            self.case('submit_closes_'+label,commands)

        commands = self.setup() + self.count('@e[tag=un.card,scores={ct_id=101}]', 108, 'deck_total_108')
        for kind in range(54):
            expected = 4 if kind >= 52 else 1 if kind % 13 == 0 else 2
            commands += self.count(f'@e[tag=un.card,scores={{ct_id=101,un_card={kind}}}]', expected, f'deck_kind_{kind}')
        for colour in range(4):
            commands += self.count(f'@e[tag=un.card,scores={{ct_id=101,un_color={colour}}}]', 25, f'deck_colour_{colour}')
        self.case('distribution', commands)

        commands = self.setup() + [f'execute as {A} at @s run function uno:round/start']
        for _ in range(22):
            commands += [f'scoreboard players set {A} un_timer 0', f'execute as {A} at @s run function uno:round/deal_tick']
        for seat in (1, 6, 8):
            commands += self.score(person(seat), 'un_count', 7, f'deal_seat_{seat}_seven')
            commands += self.count(f'@e[tag=un.card,scores={{ct_id=101,un_owner={seat}}}]', 7, f'deal_owner_{seat}_seven')
        commands += self.count('@e[tag=un.card,scores={ct_id=101,un_owner=0}]', 86, 'deal_86_library')
        commands += self.count('@e[tag=un.card,scores={ct_id=101,un_owner=-1}]', 1, 'deal_one_discard')
        commands += self.score(A, 'un_state', 2, 'deal_enters_turn') + self.score(A, 'un_value', '0..9', 'deal_starts_number')
        commands += self.queue(21, 'deal_queues_each_of_21_cards')
        commands += ['scoreboard players set #queue_bad ut 0']
        commands += [f'scoreboard players set #queued_seat_{seat} ut 0' for seat in (1, 6, 8)]
        commands += [f'function uno_test:queue_check with entity {A} data.uno.deal_queue[{index}]' for index in range(21)]
        commands += self.score('#queue_bad', 'ut', 0, 'deal_queue_indices_match_owned_cards')
        for seat in (1, 6, 8):
            commands += self.score(f'#queued_seat_{seat}', 'ut', 7, f'deal_queue_seat_{seat}_seven')
        self.case('deal_sparse', commands)

        for seats in [(1, 8), tuple(range(1, 9))]:
            size = len(seats)
            commands = self.setup(seats) + [f'execute as {A} at @s run function uno:round/start']
            for _ in range(size * 7 + 1):
                commands += [f'scoreboard players set {A} un_timer 0', f'execute as {A} at @s run function uno:round/deal_tick']
            for seat in seats:
                commands += self.score(person(seat), 'un_count', 7, f'deal_{size}p_seat_{seat}_seven')
                commands += self.count(f'@e[tag=un.card,scores={{ct_id=101,un_owner={seat}}}]', 7, f'deal_{size}p_owner_{seat}_seven')
            commands += self.count('@e[tag=un.card,scores={ct_id=101,un_owner=0}]', 107 - size * 7, f'deal_{size}p_library')
            commands += self.count('@e[tag=un.card,scores={ct_id=101,un_owner=-1}]', 1, f'deal_{size}p_one_discard')
            commands += self.score(A, 'un_state', 2, f'deal_{size}p_enters_turn')
            self.case(f'deal_boundary_{size}', commands)

        commands = self.setup()
        for direction, current, expected, label in [(1, 1, 6, 'forward_gap'), (1, 8, 1, 'forward_wrap'), (-1, 1, 8, 'reverse_wrap'), (-1, 8, 6, 'reverse_gap')]:
            commands += [f'scoreboard players set {A} un_dir {direction}', f'scoreboard players set {A} un_turn {current}', f'execute as {A} at @s run function uno:system/context', f'execute as {A} at @s run function uno:round/step']
            commands += self.score(A, 'un_turn', expected, 'sparse_' + label)
        self.case('sparse_step', commands)

        for name, selected, kind, topidx, expected_turn in [('same_colour', 6, 5, 1, 6), ('same_number', 56, 31, 6, 6), ('same_symbol', 36, 23, 11, 8)]:
            commands = self.setup() + self.normal_hands([selected, 9]) + self.top(topidx) + self.play(1, kind)
            commands += self.score(card(selected), 'un_owner', -1, name + '_accepted')
            commands += self.score(person(1), 'un_count', 1, name + '_count') + self.score(A, 'un_turn', expected_turn, name + '_turn')
            self.case(name, commands)
        commands = self.setup() + self.normal_hands([57, 9]) + self.top(6) + self.play(1, 32)
        commands += self.score(card(57), 'un_owner', 1, 'mismatch_keeps_owner') + self.score(person(1), 'un_count', 2, 'mismatch_keeps_count') + self.score(A, 'un_top', 6, 'mismatch_keeps_top')
        self.case('mismatch', commands)

        commands = self.setup() + self.normal_hands([101, 9]) + self.top(1) + self.play(1, 52, colour=3)
        commands += self.score(A, 'un_color', 3, 'wild_sets_blue') + self.score(A, 'un_top', 101, 'wild_changes_top')
        self.case('wild', commands)

        commands = self.setup() + self.normal_hands([2, 4]) + self.top(1) + self.keep_deck(14) + self.action('draw')
        commands += self.score(person(1), 'un_count', 3, 'draw_adds_one') + self.score(A, 'un_drawn', 14, 'draw_remembers_unique_index')
        commands += self.queue(1, 'draw_queues_one_card') + self.check(f'data entity {A} data.uno.deal_queue[{{seat:1,idx:14}}]', 'draw_queue_records_seat_and_index')
        commands += self.action('draw') + self.score(person(1), 'un_count', 3, 'draw_cannot_repeat')
        commands += self.queue(1, 'rejected_draw_does_not_queue_animation')
        commands += self.play(1, 3) + self.score(card(4), 'un_owner', 1, 'draw_cannot_play_old_card')
        commands += self.play(1, 1) + self.score(card(14), 'un_owner', -1, 'draw_can_play_new_duplicate') + self.score(card(2), 'un_owner', 1, 'draw_keeps_old_duplicate')
        self.case('draw_restriction', commands)

        commands = self.setup() + self.normal_hands([2, 4]) + self.top(1) + self.keep_deck(28) + self.action('draw')
        commands += self.score(A, 'un_turn', 6, 'unplayable_draw_ends_turn') + self.score(person(1), 'un_count', 3, 'unplayable_draw_kept')
        self.case('draw_unplayable', commands)
        commands = self.setup() + self.normal_hands([2, 4]) + self.top(1) + self.action('pass')
        commands += self.score(A, 'un_turn', 1, 'cannot_pass_without_draw')
        commands += self.keep_deck(14) + self.action('draw') + self.action('pass')
        commands += self.score(A, 'un_turn', 6, 'can_pass_after_draw') + self.score(person(1), 'un_count', 3, 'pass_keeps_drawn_card')
        self.case('pass', commands)

        commands = self.setup() + self.normal_hands([105, 2, 27]) + self.top(1) + self.play(1, 53)
        commands += self.score(A, 'un_state', 4, 'illegal_four_opens_challenge') + self.score(A, 'un_wildbad', 1, 'illegal_four_records_original_colour')
        commands += self.action('challenge', 6)
        commands += self.score(person(1), 'un_count', 6, 'successful_challenge_draws_offender_four') + self.score(person(6), 'un_count', 2, 'successful_challenge_spares_target') + self.score(A, 'un_turn', 6, 'successful_challenge_target_acts')
        commands += self.queue(4, 'successful_challenge_animates_four') + self.check(f'data entity {A} data.uno.deal_queue[{{seat:1}}]', 'successful_challenge_animates_offender')
        self.case('challenge_success', commands)

        commands = self.setup() + self.normal_hands([105, 27, 28]) + self.top(1) + self.play(1, 53)
        commands += self.score(A, 'un_wildbad', 0, 'legal_four_records_no_current_colour') + self.action('challenge', 6)
        commands += self.score(person(6), 'un_count', 8, 'failed_challenge_draws_six') + self.score(A, 'un_turn', 8, 'failed_challenge_skips_target')
        commands += self.queue(6, 'failed_challenge_animates_six') + self.check(f'data entity {A} data.uno.deal_queue[{{seat:6}}]', 'failed_challenge_animates_target')
        self.case('challenge_fail', commands)

        commands = self.setup() + self.normal_hands([105, 27, 28]) + self.top(1) + self.play(1, 53) + self.action('accept', 6)
        commands += self.score(person(6), 'un_count', 6, 'accepted_four_draws_four') + self.score(A, 'un_turn', 8, 'accepted_four_skips_target')
        commands += self.queue(4, 'accepted_four_animates_four')
        self.case('accept_four', commands)
        commands = self.setup() + self.normal_hands([105, 2, 27]) + self.top(1) + [f'scoreboard players set {A} un_challenge 0', f'scoreboard players set {A} un_say 0', f'scoreboard players set {A} un_chosen 3', f'scoreboard players set {A} un_wildbad 0'] + self.play(1, 53)
        commands += self.score(person(1), 'un_count', 3, 'challenge_disabled_rejects_illegal_four') + self.score(A, 'un_state', 2, 'illegal_four_keeps_turn')
        commands += self.score(A, 'un_say', 0, 'illegal_four_preserves_call_state') + self.score(A, 'un_chosen', 3, 'illegal_four_preserves_chosen_colour') + self.score(A, 'un_wildbad', 0, 'illegal_four_preserves_challenge_state')
        self.case('challenge_disabled', commands)

        for action in ('accept', 'challenge'):
            commands = self.setup() + self.normal_hands([105]) + self.top(1) + self.play(1, 53)
            commands += self.score(A, 'un_state', 4, 'last_four_waits_' + action) + self.score(A, 'un_winner', 1, 'last_four_remembers_winner_' + action)
            commands += self.action(action, 6)
            commands += self.score(A, 'un_state', 5, 'last_four_wins_after_' + action) + self.score(person(6), 'un_count', 6 if action == 'accept' else 8, 'last_four_penalty_' + action)
            commands += self.score(person(1), 'un_score', '1..', 'last_four_counts_penalty_points_' + action)
            self.case('last_four_' + action, commands)

        for name, kind, idx in [('reverse', 11, 12), ('skip', 10, 11)]:
            commands = self.setup((1, 8)) + self.normal_hands([idx, 2], (1, 8)) + self.top(1) + self.play(1, kind)
            commands += self.score(A, 'un_turn', 1, 'two_player_' + name + '_returns_actor')
            if name == 'reverse':
                commands += self.score(A, 'un_dir', -1, 'two_player_reverse_changes_direction')
            self.case('two_' + name, commands)
        commands = self.setup() + self.normal_hands([12, 2]) + self.top(1) + self.play(1, 11)
        commands += self.score(A, 'un_turn', 8, 'three_player_reverse_uses_previous') + self.score(A, 'un_dir', -1, 'three_player_reverse_direction')
        self.case('three_reverse', commands)
        commands = self.setup() + self.normal_hands([13, 2]) + self.top(1) + self.play(1, 12)
        commands += self.score(person(6), 'un_count', 4, 'draw_two_penalty') + self.score(A, 'un_turn', 8, 'draw_two_skips_target')
        commands += self.queue(2, 'draw_two_animates_both_cards') + self.check(f'data entity {A} data.uno.deal_queue[{{seat:6}}]', 'draw_two_animates_target')
        self.case('draw_two', commands)
        commands = self.setup() + self.normal_hands([13]) + self.top(1) + self.play(1, 12)
        commands += self.score(person(6), 'un_count', 4, 'last_draw_two_applied') + self.score(A, 'un_state', 5, 'last_draw_two_then_wins')
        self.case('last_draw_two', commands)

        commands = self.setup() + self.normal_hands([2, 3]) + self.top(1) + self.play(1, 1, say=0)
        commands += self.score(A, 'un_state', 3, 'uno_window_pauses_turn') + self.score(A, 'un_timer', 60, 'uno_window_60_ticks') + self.score(A, 'un_turn', 1, 'uno_window_keeps_turn')
        commands += self.action('catch', 1) + self.score(person(1), 'un_count', 1, 'cannot_catch_self')
        commands += self.action('catch', 6) + self.score(person(1), 'un_count', 3, 'catch_draws_two') + self.score(A, 'un_turn', 6, 'catch_resumes_next_turn')
        commands += self.queue(2, 'caught_uno_animates_two') + self.check(f'data entity {A} data.uno.deal_queue[{{seat:1}}]', 'caught_uno_animates_offender')
        commands += self.action('catch', 8) + self.score(person(1), 'un_count', 3, 'cannot_catch_twice')
        self.case('uno_catch', commands)
        commands = self.setup() + self.normal_hands([2, 3]) + self.top(1) + self.play(1, 1, say=0) + self.action('call')
        commands += self.score(person(1), 'un_count', 1, 'late_call_no_penalty') + self.score(A, 'un_turn', 6, 'late_call_resumes_turn') + self.score(A, 'un_called', 1, 'late_call_recorded')
        self.case('uno_call', commands)
        commands = self.setup() + self.normal_hands([2, 3]) + self.top(1) + [f'scoreboard players set {A} un_window 2'] + self.play(1, 1, say=0)
        commands += [f'execute as {A} at @s run function uno:round/uno_tick'] + self.score(A, 'un_state', 3, 'uno_timer_waits_first_tick')
        commands += [f'execute as {A} at @s run function uno:round/uno_tick'] + self.score(A, 'un_state', 2, 'uno_timer_expires_second_tick') + self.score(person(1), 'un_count', 1, 'uncaught_uno_no_penalty')
        self.case('uno_timer', commands)
        commands = self.setup() + self.normal_hands([2, 3]) + self.top(1) + [f'scoreboard players set {A} un_auto 1'] + self.play(1, 1, say=0)
        commands += self.score(A, 'un_state', 2, 'auto_uno_avoids_window') + self.score(A, 'un_turn', 6, 'auto_uno_resumes_turn')
        self.case('uno_auto', commands)

        commands = self.setup() + self.normal_hands([2, 3]) + self.top(1) + self.keep_deck(4, 5, 6, 7)
        commands += ['scoreboard players set @e[tag=un.card,scores={ct_id=101,un_owner=0}] un_owner -1', f'execute as {A} at @s run function uno:system/context', f'execute as {A} at @s run function uno:deck/reshuffle']
        commands += self.score(card(1), 'un_owner', -1, 'reshuffle_keeps_top') + self.count('@e[tag=un.card,scores={ct_id=101,un_owner=0}]', 4, 'reshuffle_returns_other_discards') + self.score(card(2), 'un_owner', 1, 'reshuffle_keeps_hands')
        self.case('reshuffle', commands)
        commands = self.setup() + self.normal_hands([2, 3]) + self.top(1) + self.keep_deck() + self.action('draw')
        commands += self.score(person(1), 'un_count', 2, 'empty_deck_no_phantom_card') + self.score(A, 'un_turn', 6, 'empty_deck_finishes_without_recursion')
        commands += self.queue(0, 'empty_deck_no_phantom_animation')
        self.case('empty_deck', commands)

        # Visual queues must not delay, replay, or change authoritative hand ownership.
        commands = self.setup() + self.normal_hands([2, 3]) + self.top(1) + self.keep_deck(4, 5, 6)
        commands += [f'execute as {A} at @s run function uno:system/context', 'scoreboard players set #seat un_ctx 6']
        commands += [f'execute as {A} at @s run function uno:deck/take'] * 3
        commands += self.queue(3, 'animation_three_successful_takes_queued') + self.score(person(6), 'un_count', 5, 'animation_hands_arrive_before_visuals')
        commands += ['scoreboard players set #seat un_ctx 77', 'scoreboard players set #draw_idx un_ctx 88', f'execute as {A} at @s run function uno:animation/tick']
        commands += self.queue(2, 'animation_first_tick_launches_one') + self.score(A, 'un_anim_wait', 1, 'animation_first_tick_sets_cooldown')
        commands += [f'execute as {A} at @s run function uno:animation/tick']
        commands += self.queue(2, 'animation_second_tick_waits') + self.score(A, 'un_anim_wait', 0, 'animation_second_tick_expires_cooldown')
        commands += [f'execute as {A} at @s run function uno:animation/tick']
        commands += self.queue(1, 'animation_third_tick_launches_second')
        commands += [f'execute as {A} at @s run function uno:animation/tick'] * 2
        commands += self.queue(0, 'animation_fifth_tick_launches_third')
        commands += self.score('#seat', 'un_ctx', 77, 'animation_preserves_logic_seat') + self.score('#draw_idx', 'un_ctx', 88, 'animation_preserves_logic_index')
        commands += self.count('@e[tag=un.card,scores={ct_id=101,un_idx=4..6,un_owner=6}]', 3, 'animation_preserves_all_drawn_owners')
        commands += self.score(person(6), 'un_count', 5, 'animation_does_not_grant_cards_twice')
        commands += self.count('@e[type=minecraft:item,tag=ct.visual_only]', 0, 'animation_without_online_receiver_leaves_no_drops')
        self.case('animation_rhythm', commands)

        for phase in (1, 2, 3, 4, 5):
            commands = self.setup() + ['scoreboard players set #seat un_ctx 6']
            commands += [f'execute as {A} at @s run function uno:deck/take'] * 2
            commands += [f'scoreboard players set {A} un_state {phase}', f'scoreboard players set {A} un_timer 47', f'execute as {A} at @s run function uno:system/tick']
            commands += self.queue(1, f'phase_{phase}_system_tick_launches_visual')
            if phase == 5:
                commands += self.score(A, 'un_timer', 47, 'result_waits_for_remaining_visuals')
            commands += [f'execute as {A} at @s run function uno:system/tick']
            commands += self.queue(1, f'phase_{phase}_system_tick_honours_cooldown')
            commands += [f'execute as {A} at @s run function uno:system/tick']
            commands += self.queue(0, f'phase_{phase}_system_tick_drains_visuals')
            commands += self.score(person(6), 'un_count', 2, f'phase_{phase}_visuals_preserve_hand')
            self.case(f'animation_phase_{phase}', commands)

        commands = self.setup() + self.table(202, (1, 8))
        commands += [f'execute as {A} at @s run function uno:system/context', 'scoreboard players set #seat un_ctx 6', f'execute as {A} at @s run function uno:deck/take', f'execute as {A} at @s run function uno:visual/ensure_box']
        commands += [f'execute as {B} at @s run function uno:system/context', 'scoreboard players set #seat un_ctx 8']
        commands += [f'execute as {B} at @s run function uno:deck/take'] * 2
        commands += [f'execute as {B} at @s run function uno:visual/ensure_box', f'execute as {A} at @s run function uno:animation/tick']
        commands += self.queue(0, 'animation_table_a_drains_only_own_queue') + self.queue(2, 'animation_table_b_queue_untouched', 202)
        for table, x in ((101, 0.0), (202, 24.0)):
            commands += [f'summon minecraft:item {x} 65 0.0 {{Tags:["ut.fixture","ct.dealt_card","ct.visual_only","ut.flight_{table}"],Item:{{id:"minecraft:paper",count:1}},PickupDelay:32767s}}',
                         f'scoreboard players set @e[type=minecraft:item,tag=ut.flight_{table}] ct_id {table}']
        commands += self.count('@e[type=minecraft:item,tag=ct.visual_only,scores={ct_id=202}]', 1, 'animation_fixture_has_foreign_flying_card')
        commands += [f'execute as {A} at @s run function uno:game/abort']
        commands += self.queue(0, 'animation_abort_clears_own_queue') + self.queue(2, 'animation_abort_preserves_other_queue', 202)
        commands += self.count('@e[type=minecraft:item,tag=ct.visual_only,scores={ct_id=101}]', 0, 'animation_abort_clears_own_flying_cards')
        commands += self.count('@e[type=minecraft:item,tag=ct.visual_only,scores={ct_id=202}]', 1, 'animation_abort_preserves_other_flying_cards')
        commands += self.count('@e[tag=un.box,scores={ct_id=101}]', 0, 'animation_abort_clears_own_box')
        commands += self.count('@e[tag=un.box,scores={ct_id=202}]', 1, 'animation_abort_preserves_other_box')
        self.case('animation_isolation', commands)

        for capacity in (4, 8):
            commands = self.setup((1, 2)) + [f'scoreboard players set {A} ct_capacity {capacity}', f'execute as {A} at @s run function uno:round/start']
            box = '@e[type=minecraft:item_display,tag=un.box,scores={ct_id=101},limit=1]'
            commands += self.count('@e[type=minecraft:item_display,tag=un.box,scores={ct_id=101}]', 1, f'box_{capacity}p_one_during_deal')
            commands += self.check(f'entity {box[:-1]},nbt={{Pos:[0d,65.095d,0d]}}]', f'box_{capacity}p_center_during_deal')
            commands += [f'data modify storage uno_test:visual uuid set from entity {box} UUID']
            for _ in range(15):
                commands += [f'scoreboard players set {A} un_timer 0', f'execute as {A} at @s run function uno:round/deal_tick']
            commands += self.count('@e[type=minecraft:item_display,tag=un.box,scores={ct_id=101}]', 1, f'box_{capacity}p_one_after_deal')
            commands += [f'execute store success score #box_changed ut run data modify storage uno_test:visual uuid set from entity {box} UUID']
            commands += self.score('#box_changed', 'ut', 0, f'box_{capacity}p_same_entity_after_deal')
            commands += [f'execute as {A} at @s run function uno:system/reload'] * 2
            commands += self.count('@e[type=minecraft:item_display,tag=un.box,scores={ct_id=101}]', 1, f'box_{capacity}p_reload_does_not_duplicate')
            commands += [f'execute store success score #box_changed ut run data modify storage uno_test:visual uuid set from entity {box} UUID']
            commands += self.score('#box_changed', 'ut', 0, f'box_{capacity}p_same_entity_after_reload')
            commands += self.queue(14, f'box_{capacity}p_reload_preserves_deal_queue')
            commands += [f'execute as {A} at @s run function uno:round/start']
            commands += self.count('@e[type=minecraft:item_display,tag=un.box,scores={ct_id=101}]', 1, f'box_{capacity}p_one_between_rounds')
            commands += [f'execute store success score #box_changed ut run data modify storage uno_test:visual uuid set from entity {box} UUID']
            commands += self.score('#box_changed', 'ut', 0, f'box_{capacity}p_same_entity_between_rounds')
            commands += self.check(f'entity {box[:-1]},nbt={{Pos:[0d,65.095d,0d]}}]', f'box_{capacity}p_stays_center_between_rounds')
            commands += self.queue(0, f'box_{capacity}p_new_round_clears_previous_queue')
            commands += [f'execute as {A} at @s run function uno:game/abort']
            commands += self.count('@e[type=minecraft:item_display,tag=un.box,scores={ct_id=101}]', 0, f'box_{capacity}p_abort_removes_box')
            self.case(f'box_lifecycle_{capacity}', commands)

        commands = self.setup() + self.normal_hands([2]) + self.top(1) + self.seat(1, -0.85, -1.42) + self.seat(1, 24.5, 0, 202) + self.play(1, 1)
        rocket = '@e[type=minecraft:firework_rocket,tag=un.firework,scores={ct_id=101,un_seat=1},limit=1]'
        commands += self.count('@e[type=minecraft:firework_rocket,tag=un.firework,scores={ct_id=101,un_seat=1}]', 1, 'winner_creates_one_tagged_firework')
        commands += self.check(f'entity {rocket[:-1]},nbt={{Pos:[-0.85d,65.32d,-1.42d]}}]', 'winner_firework_at_winning_seat')
        commands += self.check(f'data entity {rocket} FireworksItem.components."minecraft:fireworks".explosions[{{shape:"large_ball",has_trail:1b,has_twinkle:1b}}]', 'winner_firework_has_sk_effects')
        for index, colour in enumerate((16733525, 16777045, 5635925, 5592575)):
            commands += [f'execute store result score #firework_colour ut run data get entity {rocket} FireworksItem.components."minecraft:fireworks".explosions[0].colors[{index}]']
            commands += self.score('#firework_colour', 'ut', colour, f'winner_firework_sk_colour_{index}')
        commands += [f'execute store result score #firework_colour ut run data get entity {rocket} FireworksItem.components."minecraft:fireworks".explosions[0].fade_colors[0]']
        commands += self.score('#firework_colour', 'ut', 16777215, 'winner_firework_sk_fade_colour')
        commands += self.count('@e[type=minecraft:firework_rocket,tag=un.firework,scores={ct_id=202}]', 0, 'winner_firework_ignores_foreign_same_seat')
        commands += [f'scoreboard players operation #winner_score ut = {person(1)} un_score', f'execute as {A} at @s run function uno:round/win']
        commands += self.count('@e[type=minecraft:firework_rocket,tag=un.firework,scores={ct_id=101}]', 1, 'winner_reentry_does_not_repeat_firework')
        commands += self.check(f'score {person(1)} un_score = #winner_score ut', 'winner_reentry_does_not_repeat_points')
        self.case('winner_firework', commands)

        for action in ('accept', 'challenge'):
            commands = self.setup() + self.normal_hands([105]) + self.top(1) + self.seat(1, -0.85, -1.42) + self.play(1, 53)
            commands += self.count('@e[type=minecraft:firework_rocket,tag=un.firework]', 0, 'last_four_no_firework_before_' + action)
            commands += self.action(action, 6)
            commands += self.count('@e[type=minecraft:firework_rocket,tag=un.firework,scores={ct_id=101,un_seat=1}]', 1, 'last_four_firework_after_' + action)
            commands += self.queue(4 if action == 'accept' else 6, 'last_four_penalty_visuals_before_result_' + action)
            self.case('last_four_firework_' + action, commands)

        commands = self.setup() + self.normal_hands([2, 3]) + self.top(1) + self.table(202, (1, 8)) + self.hand(1, [2, 3], 202) + self.hand(8, [51, 77], 202) + self.top(1, 202)
        commands += self.actor(1, 202) + [f'scoreboard players set {person(1, 202)} un_pick 1', f'execute as {A} at @s run function uno:action/play']
        commands += self.score(card(2), 'un_owner', 1, 'foreign_actor_cannot_play')
        commands += self.play(1, 1)
        commands += self.score(card(2), 'un_owner', -1, 'table_a_can_play') + self.score(card(2, 202), 'un_owner', 1, 'table_a_does_not_change_b')
        commands += [f'execute as {A} at @s run function uno:game/cleanup']
        commands += self.count('@e[tag=un.card,scores={ct_id=101}]', 0, 'cleanup_removes_a_cards') + self.count('@e[tag=un.card,scores={ct_id=202}]', 108, 'cleanup_preserves_b_deck') + self.score(B, 'un_state', 2, 'cleanup_preserves_b_phase') + self.score(A, 'ct_state', 0, 'cleanup_returns_a_lobby')
        self.case('isolation_cleanup', commands)

        for phase in (2, 3, 4, 5):
            commands = self.setup() + self.normal_hands([2, 3]) + self.top(1)
            commands += [f'execute as {A} at @s run function uno:visual/setup', f'scoreboard players set {A} un_state {phase}', f'scoreboard players set {A} un_pending 1', f'scoreboard players set {A} un_timer 47', f'execute as {A} at @s run function uno:game/abort']
            commands += self.score(A, 'un_state', 0, f'abort_phase_{phase}_resets_phase') + self.score(A, 'ct_state', 0, f'abort_phase_{phase}_returns_lobby') + self.score(A, 'un_timer', 0, f'abort_phase_{phase}_clears_timer') + self.score(A, 'un_pending', 0, f'abort_phase_{phase}_clears_pending')
            commands += self.count('@e[tag=un.card,scores={ct_id=101}]', 0, f'abort_phase_{phase}_clears_cards') + self.count('@e[tag=un.visual,scores={ct_id=101}]', 0, f'abort_phase_{phase}_clears_displays') + self.check('entity @e[type=minecraft:marker,tag=ut.controller,tag=!un.controller,scores={ct_id=101},limit=1]', f'abort_phase_{phase}_clears_controller_tag')
            commands += self.queue(0, f'abort_phase_{phase}_clears_animation_queue') + self.score(A, 'un_anim_wait', 0, f'abort_phase_{phase}_clears_animation_cooldown')
            commands += [f'execute as {A} at @s run function uno:game/abort'] + self.score(A, 'ct_state', 0, f'abort_phase_{phase}_repeat_safe')
            self.case(f'abort_phase_{phase}', commands)

        commands = self.setup() + self.normal_hands([2, 3]) + self.top(1) + self.keep_deck(4, 5, 6)
        commands += ['scoreboard players set #seat un_ctx 6'] + [f'execute as {A} at @s run function uno:deck/take'] * 3
        commands += [f'execute as {A} at @s run function uno:animation/tick', f'data modify storage uno_test:animation queue set from entity {A} data.uno.deal_queue']
        commands += [f'execute as {A} at @s run function uno:system/reload'] * 2
        commands += self.queue(2, 'reload_animation_keeps_remaining_queue') + self.score(A, 'un_anim_wait', 1, 'reload_animation_keeps_cooldown')
        commands += [f'execute store success score #queue_changed ut run data modify storage uno_test:animation queue set from entity {A} data.uno.deal_queue']
        commands += self.score('#queue_changed', 'ut', 0, 'reload_animation_keeps_same_pending_cards')
        commands += [f'execute as {A} at @s run function uno:animation/tick']
        commands += self.queue(2, 'reload_animation_resumes_wait_without_replay')
        commands += [f'execute as {A} at @s run function uno:animation/tick']
        commands += self.queue(1, 'reload_animation_resumes_next_pending_card') + self.score(person(6), 'un_count', 5, 'reload_animation_never_redeals_hands')
        self.case('reload_animation', commands)

        commands = self.setup() + self.normal_hands([2, 3]) + self.top(1)
        commands += [f'scoreboard players set {A} un_turn 6', f'scoreboard players set {A} un_dir -1', f'scoreboard players set {A} un_round 3', f'scoreboard players set {A} un_timer 47', f'execute as {A} at @s run function uno:system/reload', f'execute as {A} at @s run function uno:system/reload']
        commands += self.score(A, 'un_turn', 6, 'reload_callback_preserves_turn') + self.score(A, 'un_dir', -1, 'reload_callback_preserves_direction') + self.score(A, 'un_round', 3, 'reload_callback_preserves_round') + self.score(A, 'un_timer', 47, 'reload_callback_preserves_timer') + self.score(person(1), 'un_count', 2, 'reload_callback_preserves_count')
        self.case('reload_callback', commands)

        commands = self.setup() + self.normal_hands([2, 3]) + self.top(1) + self.keep_deck(4, 5)
        commands += ['scoreboard players set #seat un_ctx 6'] + [f'execute as {A} at @s run function uno:deck/take'] * 2
        commands += [f'scoreboard players set {A} un_turn 6', f'scoreboard players set {A} un_timer 47', 'scoreboard objectives remove un_anim_wait', 'scoreboard players set #version un_ctx 1', 'function uno:load']
        commands += self.score('#version', 'un_ctx', 3, 'migration_v1_upgrades_installation_version')
        commands += self.queue(2, 'migration_v1_preserves_pending_animation_queue') + self.score(A, 'un_anim_wait', 0, 'migration_v1_initializes_new_cooldown_objective')
        commands += self.score(A, 'un_turn', 6, 'migration_v1_preserves_turn') + self.score(A, 'un_timer', 47, 'migration_v1_preserves_timer')
        commands += self.score(person(6), 'un_count', 4, 'migration_v1_does_not_redeal_hands') + self.score(card(2), 'un_owner', 1, 'migration_v1_preserves_other_hands')
        commands += [f'execute as {A} at @s run function uno:animation/tick']
        commands += self.queue(1, 'migration_v1_queue_resumes_after_upgrade')
        self.case('migration_v1', commands)

        # A real reload runs the production load tag and then probes its completion.
        commands = self.setup() + self.normal_hands([2, 3]) + self.top(1)
        commands += [f'scoreboard players set {A} un_turn 6', f'scoreboard players set {A} un_dir -1', f'scoreboard players set {A} un_timer 47', 'scoreboard players operation #reload_seen ut = #ui_load un_ctx', 'scoreboard players set #reload_wait ut 0', 'schedule function uno_test:reload_probe 2t', 'reload']
        self.case('real_reload', commands)
        self.file('reload_probe', [
            'execute if score #ui_load un_ctx > #reload_seen ut run return run function uno_test:reload_done',
            'scoreboard players add #reload_wait ut 1',
            'execute if score #reload_wait ut matches 100.. run return run function uno_test:reload_timeout',
            'schedule function uno_test:reload_probe 1t',
        ])
        self.file('reload_timeout', ['function uno_test:fail {name:"actual_reload_completed"}', 'function uno_test:finish'])
        self.file('reload_done', self.check('score #ui_load un_ctx > #reload_seen ut', 'actual_reload_completed') + self.score(A, 'un_turn', 6, 'actual_reload_preserves_turn') + self.score(A, 'un_dir', -1, 'actual_reload_preserves_direction') + self.score(A, 'un_timer', 47, 'actual_reload_preserves_timer') + self.score(card(2), 'un_owner', 1, 'actual_reload_preserves_hand') + self.count('@e[tag=un.card,scores={ct_id=101}]', 108, 'actual_reload_preserves_deck') + ['function uno_test:finish'])
        self.file('finish', ['say UNO_TEST_FINISHED', 'function uno_test:reset'])
        self.file('bootstrap', ['forceload add 0 0 31 15', 'scoreboard objectives add ut dummy', 'scoreboard players set #passed ut 0', 'scoreboard players set #failed ut 0', 'schedule function uno_test:case/' + self.cases[0] + ' 10t'])
        for index, name in enumerate(self.cases[:-1]):
            self.files['case/' + name] += 'schedule function uno_test:case/' + self.cases[index + 1] + ' 1t\n'


def write_test_pack(output: Path, source: Path) -> tuple[Path, list[str]]:
    target = output / 'packs' / 'fimel_cards'
    shutil.copytree(source / 'data', target / 'data')
    shutil.copy2(source / 'pack.mcmeta', target / 'pack.mcmeta')
    fixture = Fixtures()
    fixture.build()
    # 包装真实入口而不替换行为，所有改动仅在新建的临时数据包副本内。
    original_ui = target / 'data/uno/function/ui/open.mcfunction'
    fixture.file('real_ui_open', original_ui.read_text(encoding='utf-8'))
    original_ui.write_text('scoreboard players add #ui_opened ut 1\nfunction uno_test:real_ui_open\n', encoding='utf-8')
    for name, body in fixture.files.items():
        dest = target / 'data' / 'uno_test' / 'function' / (name + '.mcfunction')
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(body, encoding='utf-8')
    definitions = {
        'test_environment/default.json': {'type': 'minecraft:function', 'setup': 'uno_test:bootstrap'},
        'test_instance/behaviour.json': {'type': 'minecraft:function', 'environment': 'uno_test:default', 'function': 'minecraft:always_pass', 'max_ticks': 1, 'required': True, 'setup_ticks': 200, 'structure': 'minecraft:empty'},
    }
    for name, body in definitions.items():
        dest = target / 'data' / 'uno_test' / name
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(json.dumps(body), encoding='utf-8')
    return target, fixture.expected


def run(args: argparse.Namespace) -> int:
    if args.output:
        output = args.output.resolve()
        output.mkdir(parents=True, exist_ok=False)
    else:
        output = Path(tempfile.mkdtemp(prefix='fimel-uno-gametest-'))
    _, expected = write_test_pack(output, args.pack)
    launch = args.minecraft_root / 'versions' / args.version / (args.version + '.json')
    meta = json.loads(launch.read_text(encoding='utf-8-sig'))
    classpath = [launch.with_suffix('.jar')]
    for lib in meta['libraries']:
        entry = lib.get('downloads', {}).get('artifact', {})
        if entry.get('path'):
            path = args.minecraft_root / 'libraries' / entry['path']
            if path.is_file():
                classpath.append(path)
    java = args.java or Path(shutil.which('java') or '')
    if not args.java:
        runtime = Path.home() / 'AppData/Roaming/.minecraft/runtime/java-runtime-epsilon/bin/java.exe'
        if runtime.is_file():
            java = runtime
    # 真实热重载会短暂同时保留全包两代已解析函数，避免 1.5 GB 上限引发 GC 抖动。
    options = ['-Xms256M', '-Xmx3072M', '-Djava.awt.headless=true', '-Dfile.encoding=UTF-8', '--enable-native-access=ALL-UNNAMED', '-cp', ';'.join(map(str, classpath)), 'net.minecraft.gametest.Main', '--packs', str(output / 'packs'), '--universe', str(output / 'universe'), '--tests', 'uno_test:*', '--report', str(output / 'gametest.xml')]
    argfile = output / 'java-args.txt'
    argfile.write_text('\n'.join('"' + value.replace('\\', '\\\\').replace('"', '\\"') + '"' for value in options), encoding='utf-8')
    print('UNO GameTest 输出：' + str(output), flush=True)
    start = time.monotonic()
    # 全包启动后还会执行真实 /reload；新增游戏后，完整两次加载需留足时间。
    proc = subprocess.run([str(java), '@' + str(argfile)], cwd=output, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, encoding='utf-8', errors='replace', timeout=300)
    (output / 'game.log').write_text(proc.stdout, encoding='utf-8')
    passed = set(re.findall(r'UNO_TEST_PASS ([a-z0-9_]+)', proc.stdout))
    failed = sorted(set(re.findall(r'UNO_TEST_FAIL ([a-z0-9_]+)', proc.stdout)))
    missing = sorted(set(expected) - passed)
    errors = [line for line in proc.stdout.splitlines() if any(part in line for part in ('[ERROR]', '/ERROR]', 'Failed to load', 'Failed to parse', 'Unknown function', 'Unknown or incomplete command', "Couldn't parse", 'Command execution stopped'))]
    result = {'exit_code': proc.returncode, 'seconds': round(time.monotonic() - start, 1), 'assertions': len(expected), 'passed': len(passed), 'failed': failed, 'missing': missing, 'errors': errors, 'finished': 'UNO_TEST_FINISHED' in proc.stdout, 'output': str(output)}
    (output / 'result.json').write_text(json.dumps(result, ensure_ascii=False, indent=2), encoding='utf-8')
    print(json.dumps(result, ensure_ascii=False, indent=2), flush=True)
    return int(bool(proc.returncode or failed or missing or errors or not result['finished']))


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--pack', type=Path, default=PACK)
    parser.add_argument('--minecraft-root', type=Path, default=Path('D:/PCL2/MinecraftPcl'))
    parser.add_argument('--version', default='26.2-Fabric_0.19.3')
    parser.add_argument('--java', type=Path)
    parser.add_argument('--output', type=Path, help='必须为尚不存在的新目录；省略则创建临时目录')
    return run(parser.parse_args())


if __name__ == '__main__':
    sys.exit(main())
