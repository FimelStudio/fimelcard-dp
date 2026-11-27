"""恢复染料的阶段资格、桌号隔离、宏解码和情书后续窗口路由。背包写入仅在临时世界桥接。"""
import sys
from pathlib import Path
import test_uno as base
from build_dialog_recovery import normalize_recovery


class Fixtures(base.Fixtures):
    def case(self, name, commands):
        if name == 'real_reload': self.recovery_cases()
        super().case(name, commands)

    def recovery_cases(self):
        p, table = base.person(1), base.A
        c = self.setup() + [f'tag {table} add ct.controller']
        for state in range(1, 6):
            c += [f'scoreboard players set {table} un_state {state}', 'scoreboard players set #placed ut 0',
                  f'execute as {p} run function uno:input/ensure_reopen']
            c += self.score('#placed', 'ut', 1, f'uno_recovery_available_state_{state}')
        c += [f'scoreboard players set {p} ct_id 202', 'scoreboard players set #placed ut 0', f'execute as {p} run function uno:input/ensure_reopen']
        c += self.score('#placed', 'ut', 0, 'uno_recovery_rejects_other_table')
        c += [f'scoreboard players set {p} ct_id 101', f'scoreboard players set {table} ct_state 0', f'execute as {p} run function uno:input/ensure_reopen']
        c += self.score('#placed', 'ut', 0, 'uno_recovery_rejects_finished_table')
        super().case('uno_recovery_eligibility', c)

        c = self.setup() + [f'tag {table} add ct.controller', f'tag {table} add ll.controller',
                           f'scoreboard players set {table} ct_game 17', f'tag {p} add ll.player',
                           f'tag {p} add ll.board', f'tag {p} add ll.part']
        for key, value in {'ll_table':101, 'll_seat':1, 'll_alive':1}.items(): c += [f'scoreboard players set {p} {key} {value}']
        for key, value in {'ll_epoch':9, 'll_select_epoch':0, 'll_select_actor':1, 'll_actor':1, 'll_turn':1, 'll_anim':0}.items(): c += [f'scoreboard players set {table} {key} {value}']
        for state in range(1, 5):
            c += [f'scoreboard players set {table} ll_state {state}', 'scoreboard players set #placed ut 0', f'execute as {p} run function love_letter:input/ensure_reopen']
            c += self.score('#placed', 'ut', 1, f'loveletter_recovery_available_state_{state}')
        c += [f'scoreboard players set {table} ll_state 2']
        for phase in (2, 3, 4, 5):
            c += [f'scoreboard players set {table} ll_phase {phase}', 'scoreboard players set #ll_open ut 0',
                  f'execute as {p} run function love_letter:input/reopen {{table:101}}']
            c += self.score('#ll_open', 'ut', 1, f'loveletter_reopens_pending_phase_{phase}')
            c += self.score(table, 'll_phase', phase, f'loveletter_reopen_preserves_phase_{phase}')
        c += ['scoreboard players set #ll_open ut 0', f'execute as {p} run function love_letter:input/reopen {{table:202}}']
        c += self.score('#ll_open', 'ut', 0, 'loveletter_reopen_rejects_stale_tool')
        for game in ('uno', 'love_letter'):
            c += [f'data modify storage {game}:reopen table set value 101',
                  f'execute as {p} run function uno_test:raw_place_{game} {{table:101}}']
        super().case('loveletter_recovery_routing', c)


original = base.write_test_pack


def write_test_pack(out, source):
    target, expected = original(out, source)
    for game in ('uno', 'love_letter'):
        path = target / f'data/{game}/function/input/place_reopen.mcfunction'
        (target / f'data/uno_test/function/raw_place_{game}.mcfunction').write_text(path.read_text(encoding='utf-8'), encoding='utf-8')
        path.write_text('scoreboard players add #placed ut 1\n', encoding='utf-8')
    (target / 'data/love_letter/function/ui/open.mcfunction').write_text('scoreboard players add #ll_open ut 1\n', encoding='utf-8')
    (target / 'data/love_letter/function/input/give.mcfunction').write_text('function love_letter:input/ensure_reopen\n', encoding='utf-8')
    return target, expected


if __name__ == '__main__':
    for game in ('uno', 'love_letter'):
        root = base.PACK / f'data/{game}/function'
        for name in ('input/give', 'input/tick', 'input/drop', 'input/check_drop', 'player/clear_state'):
            path = root / (name + '.mcfunction')
            if path.exists():
                s = path.read_text(encoding='utf-8')
                assert normalize_recovery(game, name, s) == s, (game, name, 'regeneration is not idempotent')
        s = (root / 'input/place_reopen.mcfunction').read_text(encoding='utf-8')
        assert '$give @s minecraft:purple_dye' in s and 'item replace' not in s and 'hotbar.' not in s and 'minecraft:item_model' not in s
    base.Fixtures = Fixtures
    base.write_test_pack = write_test_pack
    sys.exit(base.main())
