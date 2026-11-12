"""在临时原版世界验证情书视线、原子出牌与私人选择；用盔甲架模拟玩家身体。

测试副本仅将玩家选择器换成测试实体，保留生产射线、规则和 Dialog 宏。
真人坐姿准星、轮廓发光与窗口点击仍需客户端验收。
"""
from pathlib import Path
import shutil
import re

from test_love_letter_engine import TABLE, OTHER, part, run
from test_love_letter_ui import Suite as UISuite, person, prepare_target as prepare_ui


PACK = Path(__file__).resolve().parents[1]


class Suite(UISuite):
    def aimed(self, hands=(2, 5, 4), extra=0, deck=(0, 1, 2, 3)):
        return self.setup(hands, extra=extra, deck=deck) + [
            f'scoreboard players set {TABLE} ll_timeout 0',
            f'tp {person()} 8 64 5.5 0 0',
            f'tp {person(2)} 8 64 10.5 180 0',
            f'tp {person(3)} 10.5 64 8 90 0',
            'scoreboard players set #ui_compiled lt 0',
        ]

    def q(self, epoch=12345):
        return [f'execute as {person()} at @s run function love_letter:direct/play {{table:101,owner:1,epoch:{epoch},slot:0}}',
                'function love_letter:input/tick']

    def choice(self, code):
        return [f'scoreboard players operation #choice lt = {TABLE} ll_epoch',
                'scoreboard players set #thousand lt 1000',
                'scoreboard players operation #choice lt *= #thousand lt',
                f'scoreboard players add #choice lt {code}',
                f'scoreboard players operation {person()} ll_action = #choice lt',
                f'execute as {person()} at @s run function love_letter:input/submit']

    def head(self, target, epoch=12345, table=101, owner=1):
        return [f'execute as {person()} at @s run function love_letter:targeting/confirm {{table:{table},owner:{owner},epoch:{epoch},target:{target}}}',
                'function love_letter:input/tick']

    def build(self):
        self.prepare()
        self.file('person', '''
tag @s add lt.fixture
tag @s add lt.person
tag @s add ll.player
tag @s add ct.player
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ll_table $(table)
$scoreboard players set @s ll_seat $(seat)
$scoreboard players set @s ct_seat $(seat)
scoreboard players set @s ll_pick -1
data merge entity @s {NoGravity:1b,Invisible:1b,Invulnerable:1b}
''')
        c = self.aimed() + self.call('targeting/tick')
        c += self.score('#aim', 'll_ctx', 2, 'ray_hits_facing_player')
        c += self.check(f'entity {person(2)[:-1]},tag=ll.aim_preview]', 'facing_player_highlighted')
        c += self.count('@e[tag=ll.aim_ray]', 0, 'ray_marker_cleaned')
        c += self.q() + self.score('#ok', 'll_ctx', 1, 'aimed_priest_q_accepted')
        c += self.data(TABLE, 'data.love_letter.action.target', 2, 'aimed_priest_target_locked')
        c += self.check(f'data entity {TABLE} data.ll_private{{kind:"priest",seat:1,target:2,target_card:5}}', 'priest_only_selected_card')
        c += self.data(part(), 'data.discards', [2], 'aimed_card_discarded_once')
        self.case('aimed_priest', c)

        c = self.aimed() + [f'tp {person()} 8 64 5.5 180 0', f'scoreboard players set {TABLE} ll_actor 7'] + self.q()
        c += self.score('#ok', 'll_ctx', 0, 'missing_aim_rejected') + self.score('#error', 'll_ctx', 3, 'missing_aim_reason')
        c += self.score(part(), 'll_hand', 2, 'missing_aim_hand_kept') + self.score(part(), 'll_extra', 0, 'missing_aim_draw_kept')
        c += self.score(TABLE, 'll_phase', 1, 'missing_aim_phase_kept') + self.score(TABLE, 'll_actor', 7, 'missing_aim_actor_kept')
        c += self.score(TABLE, 'll_card', -1, 'missing_aim_card_state_kept') + self.data(part(), 'data.discards', [], 'missing_aim_no_discard')
        self.case('missing_aim', c)

        c = self.aimed() + [f'scoreboard players set {part(2)} ll_protect 1'] + self.call('targeting/tick') + self.q()
        c += self.score('#error', 'll_ctx', 4, 'protected_aim_reason') + self.score(part(), 'll_hand', 2, 'protected_aim_hand_kept')
        c += self.count('@e[tag=ll.aim_preview]', 0, 'protected_target_not_highlighted')
        c += self.data(part(), 'data.discards', [], 'protected_aim_no_discard')
        self.case('protected_aim', c)

        c = self.aimed((5, 2, 4), extra=8) + self.q()
        c += self.score('#ok', 'll_ctx', 0, 'countess_prince_q_rejected')
        c += self.score('#error', 'll_ctx', 2, 'countess_prince_rule_reason')
        c += self.score(part(), 'll_hand', 5, 'countess_prince_hand_kept')
        c += self.score(part(), 'll_extra', 8, 'countess_prince_extra_kept')
        c += self.data(part(), 'data.discards', [], 'countess_prince_no_discard')
        self.case('countess_prince_q', c)

        c = self.aimed() + [f'scoreboard players set {part(2)} ll_protect 1', f'scoreboard players set {part(3)} ll_protect 1'] + self.q()
        c += self.score('#ok', 'll_ctx', 1, 'no_legal_target_can_discard') + self.data(part(), 'data.discards', [2], 'no_legal_target_no_softlock')
        c += self.data(TABLE, 'data.love_letter.action.target', 0, 'no_legal_target_no_effect')
        self.case('all_protected', c)

        for pitch, yaw in ((0, 180), (60, 0)):
            c = self.aimed((5, 2, 4), extra=4) + [f'tp {person()} 8 64 5.5 {yaw} {pitch}'] + self.q()
            key = 'prince_down' if pitch else 'prince_no_aim'
            c += self.data(TABLE, 'data.love_letter.action.target', 1, key + '_self')
            c += self.data(part(), 'data.discards', [5, 4], key + '_discards_own') + self.score(part(), 'll_hand', 0, key + '_redraw')
            self.case(key, c)

        c = self.aimed((5, 2, 4), extra=4) + self.q()
        c += self.data(TABLE, 'data.love_letter.action.target', 2, 'prince_aimed_other')
        c += self.score(part(2), 'll_hand', 0, 'prince_other_redraw') + self.score(part(), 'll_hand', 4, 'prince_keeps_own')
        self.case('prince_other', c)

        c = self.aimed((1, 9, 4)) + self.q()
        c += self.score(TABLE, 'll_phase', 3, 'guard_q_opens_guess_phase') + self.score(TABLE, 'll_target', 2, 'guard_q_locks_facing_target')
        c += self.score('#ui_compiled', 'lt', 1, 'guard_q_dialog_macro_executed')
        c += ['execute store result score #buttons lt run data get storage love_letter:ui buttons'] + self.score('#buttons', 'lt', 11, 'guard_lists_nine_roles_and_navigation')
        c += self.choice(209) + self.score(part(2), 'll_alive', 0, 'guard_guess_eliminates_selected_player')
        c += self.score(part(3), 'll_alive', 1, 'guard_other_player_untouched')
        self.case('guard_dialog', c)

        c=self.aimed((1,9,4),extra=9)+[
            f'execute as {person()} at @s run function love_letter:direct/play {{table:101,owner:1,epoch:12345,slot:0}}',
            f'scoreboard players add {TABLE} ll_epoch 1',
            'function love_letter:input/tick']
        c+=self.score('#ui_compiled','lt',0,'stale_pending_choice_does_not_open')
        c+=self.count('@e[tag=ll.choice_pending]',0,'stale_pending_choice_cleared')
        c+=self.score(part(),'ll_hand',9,'stale_pending_choice_does_not_play_princess')
        self.case('stale_pending_dialog',c)

        c=self.aimed((1,9,4),extra=9)+[
            f'execute as {person()} at @s run function love_letter:direct/play {{table:101,owner:1,epoch:12345,slot:0}}',
            f'scoreboard players set {person()} ct_paused 1','function love_letter:input/tick']
        c+=self.score('#ui_compiled','lt',0,'paused_pending_choice_waits')
        c+=[f'scoreboard players set {person()} ct_paused 0','function love_letter:input/tick']
        c+=self.score('#ui_compiled','lt',1,'pending_choice_opens_after_resume')
        c+=self.count('@e[tag=ll.choice_pending]',0,'opened_pending_choice_cleared')
        self.case('paused_pending_dialog',c)

        c = self.aimed((6, 2, 4), extra=8, deck=(5, 7, 0)) + self.q()
        c += self.score(TABLE, 'll_phase', 4, 'chancellor_q_opens_keep_phase') + self.score('#ui_compiled', 'lt', 1, 'chancellor_q_dialog_macro_executed')
        c += ['execute store result score #cards lt run data get storage love_letter:ui cards.extra'] + self.score('#cards', 'lt', 3, 'chancellor_three_clickable_cards')
        c += self.choice(301) + self.score(part(), 'll_hand', 5, 'chancellor_keeps_clicked_card')
        c += self.score(TABLE, 'll_phase', 5, 'chancellor_orders_remaining')
        c += ['scoreboard players set #ui_compiled lt 0','function love_letter:input/tick']
        c += self.score('#ui_compiled','lt',1,'chancellor_next_dialog_opens_after_click_completes')
        c += self.choice(400) + self.data(TABLE, 'data.love_letter.deck', [0, 8, 7], 'chancellor_bottom_order_committed')
        self.case('chancellor_dialog', c)

        c = self.aimed() + self.setup(table=202, reset=False)
        c += [f'tp {person(2, 202)} 8 64 8 0 0'] + self.call('targeting/tick')
        c += self.score('#aim', 'll_ctx', 2, 'ray_ignores_other_table_body')
        c += self.count('@e[tag=ll.aim_preview,scores={ll_table=202}]', 0, 'other_table_not_highlighted')
        c += [f'tp {person()} 8 64 5.5 180 0'] + self.call('targeting/tick')
        c += self.count('@e[tag=ll.aim_preview]', 1, 'turning_away_retains_highlight')
        c += self.q(epoch=1) + self.data(part(), 'data.discards', [], 'old_hand_epoch_rejected')
        self.case('isolation_and_stale', c)

        c = self.aimed() + [f'tp {person(2)} 8.65 64 10.5 180 0'] + self.call('targeting/tick')
        c += self.score('#aim', 'll_ctx', 2, 'wide_body_accepts_near_miss')
        c += [f'tp {person()} 8 64 5.5 180 0'] + self.q()
        c += self.data(TABLE, 'data.love_letter.action.target', 2, 'remembered_target_used_at_q')
        self.case('wide_and_remembered', c)

        c = self.aimed() + self.call('targeting/tick') + [f'tp {person()} 8 64 5.5 -45 0'] + self.call('targeting/tick')
        c += self.score('#aim', 'll_ctx', 3, 'new_target_replaces_cached_immediately')
        c += self.score(TABLE, 'll_aimttl', 60, 'new_target_refreshes_three_seconds')
        c += [f'tp {person()} 8 64 5.5 180 0'] + self.call('targeting/tick')
        c += self.score(TABLE, 'll_aimttl', 59, 'turning_away_counts_down_each_tick')
        c += [f'scoreboard players set {TABLE} ll_aimttl 1'] + self.call('targeting/tick')
        c += self.score('#aim', 'll_ctx', 0, 'three_seconds_expires')
        c += self.count('@e[tag=ll.aim_preview]', 0, 'expired_highlight_removed')
        self.case('refresh_and_expire', c)

        c = self.aimed() + self.call('targeting/tick') + [f'tp {person()} 8 64 5.5 0 60'] + self.q()
        c += self.score('#error', 'll_ctx', 3, 'looking_down_clears_old_target')
        c += self.data(part(), 'data.discards', [], 'down_cannot_accidentally_play_at_old_target')
        self.case('down_clears', c)

        c = self.aimed((5, 2, 4), extra=4) + self.call('targeting/tick') + [f'tp {person()} 8 64 5.5 0 60'] + self.q()
        c += self.data(TABLE, 'data.love_letter.action.target', 1, 'prince_down_overrides_cached_other')
        self.case('prince_cached_self', c)

        c = self.aimed() + self.call('targeting/tick') + [f'tp {person()} 8 64 5.5 180 0', f'scoreboard players add {TABLE} ll_epoch 1'] + self.call('targeting/tick')
        c += self.score('#aim', 'll_ctx', 0, 'epoch_change_invalidates_cache')
        self.case('cached_epoch', c)

        c = self.aimed() + [f'scoreboard players set {TABLE} ll_target_mode 1'] + self.q()
        c += self.score('#error', 'll_ctx', 5, 'precise_requests_heads_before_play')
        c += self.score(part(), 'll_hand', 2, 'precise_keeps_original_card') + self.score(part(), 'll_extra', 0, 'precise_keeps_draw')
        c += self.data(part(), 'data.discards', [], 'precise_no_early_discard')
        c += self.score(TABLE, 'll_phase', 1, 'precise_keeps_play_phase')
        c += self.score(TABLE, 'll_select_epoch', 12345, 'precise_records_epoch')
        c += self.score('#head_index', 'll_ctx', 3, 'head_for_every_player')
        c += self.head(3) + self.data(TABLE, 'data.love_letter.action.target', 3, 'precise_can_choose_non_facing_player')
        c += self.check(f'data entity {TABLE} data.ll_private{{kind:"priest",seat:1,target:3,target_card:4}}', 'precise_only_targeted_private_card')
        c += self.data(part(), 'data.discards', [2], 'precise_discards_once_after_confirmation')
        c += self.score(TABLE, 'll_exact', 0, 'precise_override_cleared')
        self.case('precise_priest', c)

        for target, label in [(1, 'self'), (2, 'protected')]:
            c = self.aimed() + [f'scoreboard players set {TABLE} ll_target_mode 1', f'scoreboard players set {part(2)} ll_protect 1'] + self.q() + self.head(target)
            c += self.score('#ok', 'll_ctx', 0, 'precise_invalid_' + label)
            c += self.data(part(), 'data.discards', [], 'precise_invalid_' + label + '_no_discard')
            c += self.head(3) + self.data(TABLE, 'data.love_letter.action.target', 3, 'precise_retry_after_' + label)
            self.case('precise_invalid_' + label, c)

        c = self.aimed() + [f'scoreboard players set {TABLE} ll_target_mode 1'] + self.q() + self.head(0)
        c += self.score(TABLE, 'll_select_epoch', 0, 'cancel_closes_heads')
        c += self.data(part(), 'data.discards', [], 'cancel_no_discard') + self.score(part(), 'll_extra', 0, 'cancel_keeps_both_cards')
        self.case('precise_cancel', c)

        for params, label in [({'epoch':1}, 'epoch'), ({'table':202}, 'table'), ({'owner':2}, 'owner')]:
            c = self.aimed() + [f'scoreboard players set {TABLE} ll_target_mode 1'] + self.q() + self.head(3, **params)
            c += self.data(part(), 'data.discards', [], 'stale_head_' + label + '_no_discard')
            self.case('stale_head_' + label, c)

        c = self.aimed((1, 9, 4), extra=9) + [f'scoreboard players set {TABLE} ll_target_mode 1'] + self.q() + self.head(2)
        c += self.score(TABLE, 'll_phase', 3, 'precise_guard_opens_guess_phase')
        c += self.score('#ui_compiled', 'lt', 1, 'precise_guard_guess_opens_next_tick')
        c += self.choice(209) + self.score(part(2), 'll_alive', 0, 'precise_guard_guesses_selected_head')
        self.case('precise_guard', c)

        c = self.aimed((5, 2, 4), extra=4) + [f'scoreboard players set {TABLE} ll_target_mode 1'] + self.q() + self.head(1)
        c += self.data(TABLE, 'data.love_letter.action.target', 1, 'precise_prince_can_select_own_head')
        self.case('precise_prince', c)

        c = self.setup((2, 5, 4), seats=(1, 6, 8), extra=0) + [f'scoreboard players set {TABLE} ll_timeout 0', f'scoreboard players set {TABLE} ll_target_mode 1'] + self.q() + self.head(8)
        c += self.data(TABLE, 'data.love_letter.action.target', 8, 'precise_sparse_seat_is_not_hotbar_index')
        self.case('precise_sparse', c)

        c = self.aimed() + [f'scoreboard players set {TABLE} ll_target_mode 1'] + self.q() + self.setup(table=202, reset=False) + self.head(3)
        c += self.data(TABLE, 'data.love_letter.action.target', 3, 'precise_rebuilds_own_table_context')
        c += self.data(part(3, 202), 'data.discards', [], 'precise_never_discards_other_table_card')
        self.case('precise_two_tables', c)

        for card, yaw, target, mode in [(4, 0, 1, 0), (5, 180, 1, 0), (4, 0, 1, 1)]:
            c = self.aimed((card, 2, 4), extra=0) + [
                f'scoreboard players set {TABLE} ll_target_mode {mode}',
                f'item replace entity {person()} weapon.mainhand with minecraft:purple_dye[minecraft:custom_data={{love_letter:{{hand:1b,card:{card}}}}}]',
                f'tp {person()} 8 64 5.5 {yaw} 0'] + self.call('targeting/tick')
            c += self.score(person(), 'll_hint_target', target, f'held_self_card_{card}_mode{mode}_hints_own_name')
            self.case(f'held_self_card_{card}_mode{mode}', c)

        c = self.aimed((5, 2, 4), extra=8) + [f'scoreboard players set {TABLE} ll_target_mode 1'] + self.q()
        c += self.score('#error', 'll_ctx', 2, 'precise_countess_rule_before_head_picker')
        c += self.data(part(), 'data.discards', [], 'precise_countess_does_not_consume')
        self.case('precise_countess', c)

        c = self.aimed() + self.call('system/context') + [
            f'data modify storage love_letter:input uuid set from entity {person(2)} UUID',
            'data modify storage love_letter:input head_name set value {text:"Test 2"}',
            'data modify storage love_letter:input table set value 101', 'data modify storage love_letter:input owner set value 1',
            'data modify storage love_letter:input epoch set value 12345', 'data modify storage love_letter:input target set value 2',
            'data modify storage love_letter:input head_slot set value 0',
            f'execute as {person()} run function love_letter:targeting/head_item with storage love_letter:input']
        c += self.check(f'items entity {person()} weapon.mainhand minecraft:player_head[minecraft:custom_data~{{love_letter:{{head:1b,target:2,owner:1,table:101,epoch:12345}}}}]', 'native_head_item_and_macro_valid')
        c += self.check(f'data entity {person()} equipment.mainhand.components."minecraft:profile".id', 'head_profile_contains_uuid')
        c += [f'data modify storage love_letter_test:heads uuid set from entity {person(2)} UUID',
              f'execute store success score #uuid_diff lt run data modify storage love_letter_test:heads uuid set from entity {person()} equipment.mainhand.components."minecraft:profile".id']
        c += self.score('#uuid_diff', 'lt', 0, 'head_profile_matches_target_not_actor')
        c += [f'scoreboard players set {TABLE} ll_select_actor 1', f'scoreboard players set {TABLE} ll_select_slot 0', f'execute as {person()} run function love_letter:targeting/head_preview']
        c += self.score('#aim', 'll_ctx', 2, 'held_head_selects_its_owner')
        self.case('head_item_codec', c)
        self.finish()
        self.files['bootstrap'] = self.files['bootstrap'].replace('function love_letter_test:reset', 'scoreboard objectives add ct_seat dummy\nscoreboard objectives add ct_paused dummy\nscoreboard players set #ui_load ll_ctx 1\nfunction love_letter_test:reset')


def prepare_target(target):
    await_path = target / 'data/love_letter/function/game/await_choice.mcfunction'
    shutil.copy2(PACK / 'data/love_letter/function/game/await_choice.mcfunction', await_path)
    for name in ('visual/refresh', 'hud/refresh', 'input/give'):
        path = target / 'data/love_letter/function' / (name + '.mcfunction')
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text('return 0\n', encoding='utf-8')
    prepare_ui(target)
    # 盔甲架无快捷栏，用主手槽验证实际物品组件及宏；规则数据与生产函数保持一致。
    for path in (target / 'data/love_letter/function').rglob('*.mcfunction'):
        text = path.read_text(encoding='utf-8').replace('SelectedItem', 'equipment.mainhand')
        text = re.sub(r'hotbar\.(?:\d+|\$\([a-z_]+\))', 'weapon.mainhand', text)
        text = '\n'.join(line[1:] if line.startswith('$') and '$(' not in line else line for line in text.splitlines()) + '\n'
        path.write_text(text, encoding='utf-8')


if __name__ == '__main__':
    suite = Suite()
    suite.build()
    raise SystemExit(run(suite, prepare_target=prepare_target, prefix='fimel-loveletter-targeting-'))
