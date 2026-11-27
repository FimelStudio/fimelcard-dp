"""真实掉落物Thrower/origin验证：花火恢复入口不能被附近物品或丢弃事件时序阻断。"""
import sys
import test_uno as base
import test_dialog_recovery as recovery

P = base.person(1)
OTHER = base.person(6)


class Fixtures(recovery.Fixtures):
    def case(self, name, commands):
        if name == 'real_reload': self.hanabi_cases()
        super().case(name, commands)

    def setup_hanabi(self, reward=2):
        return self.setup() + [f'tag {P} add hb.player', f'tag {P} add hb.reward_pending',
                              f'scoreboard players set {P} hb_id 101', f'scoreboard players set {P} hb_target 7',
                              f'scoreboard players set {P} hb_drop_reward 1', f'tag {base.A} add hb.controller',
                              f'scoreboard players set {base.A} hb_id 101', f'scoreboard players set {base.A} hb_state 2',
                              f'scoreboard players set {base.A} hb_reward_pending {reward}',
                              'scoreboard players set #hb_open ut 0']

    def drop(self, tag='hr.owned', owner=P, distance=1):
        selector = f'@e[tag={tag},limit=1]'
        return [f'execute as {P} at @s positioned ~{distance} ~1 ~ run summon minecraft:item ~ ~ ~ {{Tags:["ut.fixture","{tag}"],NoGravity:1b,PickupDelay:32767s,Item:{{id:"minecraft:purple_dye",count:1,components:{{"minecraft:custom_data":{{hanabi:{{action:"reward_reopen"}}}}}}}}}}',
                f'data modify entity {selector} Thrower set from entity {owner} UUID']

    def hanabi_cases(self):
        c = self.setup_hanabi() + [f'execute as {P} at @s positioned ~0.1 ~1 ~ run summon minecraft:item ~ ~ ~ {{Tags:["ut.fixture","hr.paper"],NoGravity:1b,PickupDelay:32767s,Item:{{id:"minecraft:paper",count:1}}}}']
        c += self.drop('hr.other', OTHER, .2) + self.drop()
        c += [f'execute as {P} at @s run function hanabi:input/reopen_reward']
        c += self.score('#hb_open', 'ut', 1, 'hanabi_recovery_skips_nearer_unrelated_items')
        c += self.count('@e[tag=hr.owned]', 0, 'hanabi_recovery_consumes_owned_dye')
        c += self.count('@e[tag=hr.other]', 1, 'hanabi_recovery_keeps_other_players_dye')
        c += self.count('@e[tag=hr.paper]', 1, 'hanabi_recovery_keeps_normal_items')
        c += self.score(P, 'hb_target', 7, 'hanabi_recovery_preserves_selected_target')
        base.Fixtures.case(self, 'hanabi_recovery_ownership', c)

        c = self.setup_hanabi() + [f'execute as {P} at @s run function hanabi:input/reopen_reward']
        c += self.score('#hb_open', 'ut', 0, 'hanabi_missing_drop_does_not_open_window')
        c += self.score(P, 'hb_drop_reward', 0, 'hanabi_drop_stat_may_precede_entity')
        c += self.drop() + ['function uno_test:hanabi_fallback']
        c += self.score('#hb_open', 'ut', 1, 'hanabi_late_entity_recovers_without_second_q')
        c += self.count('@e[tag=hr.owned]', 0, 'hanabi_late_entity_is_consumed')
        base.Fixtures.case(self, 'hanabi_recovery_delayed_drop', c)

        for reward in (2, 3, 4):
            c = self.setup_hanabi(reward) + self.drop() + [f'execute as {P} at @s run function hanabi:input/reopen_reward']
            c += self.score('#hb_reward', 'ut', reward, f'hanabi_recovery_uses_saved_reward_{reward}')
            base.Fixtures.case(self, f'hanabi_saved_reward_{reward}', c)

        c = self.setup_hanabi() + self.drop() + [f'tag {P} remove hb.reward_pending', f'execute as {P} at @s run function hanabi:input/reopen_reward']
        c += self.score('#hb_open', 'ut', 0, 'hanabi_finished_reward_cannot_be_reopened')
        base.Fixtures.case(self, 'hanabi_recovery_expired', c)


def write_test_pack(out, source):
    target, expected = recovery.write_test_pack(out, source)
    p = target / 'data/hanabi/function/input/reopen_reward.mcfunction'
    p.write_text(p.read_text(encoding='utf-8').replace('@a[', '@e['), encoding='utf-8')
    (target / 'data/hanabi/function/reward/reopen.mcfunction').write_text('scoreboard players add #hb_open ut 1\nscoreboard players operation #hb_reward ut = @s hb_reward_pending\n', encoding='utf-8')
    text = (target / 'data/hanabi/function/tick.mcfunction').read_text(encoding='utf-8')
    line = next(x for x in text.splitlines() if 'hb_drop_reward=0' in x and 'input/reopen_reward' in x)
    (target / 'data/uno_test/function/hanabi_fallback.mcfunction').write_text(line.replace('@a[', '@e[') + '\n', encoding='utf-8')
    return target, expected


if __name__ == '__main__':
    base.Fixtures = Fixtures
    base.write_test_pack = write_test_pack
    sys.exit(base.main())
