"""在临时原版世界验证情书视线、原子出牌与私人选择；用盔甲架模拟玩家身体。

测试副本仅将玩家选择器换成测试实体，保留生产射线、规则和 Dialog 宏。
真人坐姿准星、轮廓发光与窗口点击仍需客户端验收。
"""
from pathlib import Path
import shutil

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
        return [f'execute as {person()} at @s run function love_letter:direct/play {{table:101,owner:1,epoch:{epoch},slot:0}}']

    def choice(self, code):
        return [f'scoreboard players operation #choice lt = {TABLE} ll_epoch',
                'scoreboard players set #thousand lt 1000',
                'scoreboard players operation #choice lt *= #thousand lt',
                f'scoreboard players add #choice lt {code}',
                f'scoreboard players operation {person()} ll_action = #choice lt',
                f'execute as {person()} at @s run function love_letter:input/submit']

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

        c = self.aimed((6, 2, 4), extra=8, deck=(5, 7, 0)) + self.q()
        c += self.score(TABLE, 'll_phase', 4, 'chancellor_q_opens_keep_phase') + self.score('#ui_compiled', 'lt', 1, 'chancellor_q_dialog_macro_executed')
        c += ['execute store result score #cards lt run data get storage love_letter:ui cards.extra'] + self.score('#cards', 'lt', 3, 'chancellor_three_clickable_cards')
        c += self.choice(301) + self.score(part(), 'll_hand', 5, 'chancellor_keeps_clicked_card')
        c += self.score(TABLE, 'll_phase', 5, 'chancellor_orders_remaining')
        c += self.choice(400) + self.data(TABLE, 'data.love_letter.deck', [0, 8, 7], 'chancellor_bottom_order_committed')
        self.case('chancellor_dialog', c)

        c = self.aimed() + self.setup(table=202, reset=False)
        c += [f'tp {person(2, 202)} 8 64 8 0 0'] + self.call('targeting/tick')
        c += self.score('#aim', 'll_ctx', 2, 'ray_ignores_other_table_body')
        c += self.count('@e[tag=ll.aim_preview,scores={ll_table=202}]', 0, 'other_table_not_highlighted')
        c += [f'tp {person()} 8 64 5.5 180 0'] + self.call('targeting/tick')
        c += self.count('@e[tag=ll.aim_preview]', 0, 'turning_away_clears_highlight')
        c += self.q(epoch=1) + self.data(part(), 'data.discards', [], 'old_hand_epoch_rejected')
        self.case('isolation_and_stale', c)
        self.finish()
        self.files['bootstrap'] = self.files['bootstrap'].replace('function love_letter_test:reset', 'scoreboard objectives add ct_seat dummy\nscoreboard players set #ui_load ll_ctx 1\nfunction love_letter_test:reset')


def prepare_target(target):
    await_path = target / 'data/love_letter/function/game/await_choice.mcfunction'
    shutil.copy2(PACK / 'data/love_letter/function/game/await_choice.mcfunction', await_path)
    for name in ('visual/refresh', 'hud/refresh', 'input/give'):
        path = target / 'data/love_letter/function' / (name + '.mcfunction')
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text('return 0\n', encoding='utf-8')
    prepare_ui(target)
    # prepare_ui copies input/give; the inventory view is outside this geometry test.
    (target / 'data/love_letter/function/input/give.mcfunction').write_text('return 0\n', encoding='utf-8')


if __name__ == '__main__':
    suite = Suite()
    suite.build()
    raise SystemExit(run(suite, prepare_target=prepare_target, prefix='fimel-loveletter-targeting-'))
