"""从实际公共点击入口验证 UNO / chess / xiangqi 设置与动态 Dialog 编译。

隔离测试副本仅将参与者选择器适配为 marker，保留真实 dialog 命令目标；
宏末尾添加哨兵，确保整条 Dialog 通过原版编译，避免静默宏失败被漏检。
"""
from pathlib import Path
import test_chess as base

ACTOR = '@e[type=minecraft:marker,tag=se.actor,limit=1]'
TABLE = '@e[type=minecraft:marker,tag=se.table,limit=1]'


class EntrySuite(base.Suite):
    def build(self):
        self.file('reset', ['kill @e[tag=se.fixture]'])
        self.file('missing_settings', ['say SETTINGS_UNEXPECTED_FALLBACK'])
        self.file('missing_rules', ['say RULES_UNEXPECTED_FALLBACK'])
        for game, namespace, prefix in [(11, 'uno', 'un'), (12, 'chess', 'ch'), (13, 'xiangqi', 'xq')]:
            commands = ['function chess_game_test:reset',
                        'summon minecraft:marker 8 64 8 {Tags:["se.fixture","se.table","ct.controller"]}',
                        'summon minecraft:marker 9 64 8 {Tags:["se.fixture","se.actor","ct.player"]}',
                        f'scoreboard players set {TABLE} ct_id 101',
                        f'scoreboard players set {TABLE} ct_game {game}',
                        f'scoreboard players set {TABLE} ct_state 0',
                        f'scoreboard players set {ACTOR} ct_id 101',
                        f'scoreboard players set {ACTOR} ct_seat 3',
                        f'scoreboard players set #dialog_compiled_{prefix} cg 0']
            if game in (12, 13):
                for objective, value in [('ch_board', 0), ('ch_palette', 0), ('ch_orient', 0), ('ch_first', 0), ('ch_time', 10), ('ch_level', 2), ('ch_hints', 1), ('ch_epoch', 1)]:
                    commands += [f'scoreboard players set {TABLE} {objective.replace("ch_", prefix + "_")} {value}']
            commands += [f'execute as {ACTOR} at @s run function cardtable:click/game_settings']
            commands += self.check(f'score {ACTOR} {prefix}_set_table matches 101', namespace + '_common_click_creates_session')
            commands += self.check(f'score {ACTOR} {prefix}_setnonce matches 1..', namespace + '_common_click_nonce')
            commands += self.score(f'#dialog_compiled_{prefix}', 'cg', 1, namespace + '_common_click_dialog_compiles')
            commands += self.count('@e[tag=ct.settings_actor]', 0, namespace + '_common_click_clears_actor')
            commands += self.count('@e[tag=ct.settings_controller]', 0, namespace + '_common_click_clears_controller')
            self.case(namespace + '_entry', commands)
        self.file('dialogs', ['say CHESS_DIALOGS_END'])
        self.case('dialogs', ['function chess_game_test:dialogs'])
        self.file('finish', ['function chess_game_test:reset', 'say CHESS_GAME_FINISHED'])
        self.file('bootstrap', ['forceload add -16 -16 63 31', 'scoreboard objectives add cg dummy', 'schedule function chess_game_test:case/' + self.cases[0] + ' 40t'])
        for index, name in enumerate(self.cases):
            self.files['case/' + name] += 'schedule function chess_game_test:' + ('case/' + self.cases[index + 1] if index + 1 < len(self.cases) else 'finish') + ' 3t\n'


original_copytree = base.shutil.copytree


def copytree(source, destination, *args, **kwargs):
    result = original_copytree(source, destination, *args, **kwargs)
    if Path(source) == base.PACK / 'data':
        root = Path(destination)
        paths = [root / 'cardtable/function/skin/open.mcfunction']
        for namespace, prefix in [('uno', 'un'), ('chess', 'ch'), ('xiangqi', 'xq')]:
            paths += list((root / namespace / 'function/settings').glob('*.mcfunction'))
            macro = root / namespace / 'function/settings/root_show.mcfunction'
            macro.write_text(macro.read_text(encoding='utf-8') + f'scoreboard players add #dialog_compiled_{prefix} cg 1\n', encoding='utf-8')
        for path in paths:
            lines = path.read_text(encoding='utf-8').splitlines()
            for index, line in enumerate(lines):
                if 'dialog show' not in line and 'tellraw' not in line:
                    lines[index] = line.replace('@a[tag=ct.settings_actor', '@e[type=minecraft:marker,tag=se.actor,tag=ct.settings_actor')
            path.write_text('\n'.join(lines) + '\n', encoding='utf-8')
    return result


if __name__ == '__main__':
    base.Suite = EntrySuite
    base.shutil.copytree = copytree
    raise SystemExit(base.main())
