"""在独立26.2世界编译连续交互窗口，并检查自身退出不改变游戏选择。"""
import json
import re
import sys
from pathlib import Path
import test_uno as base
from build_dialog_cursor import PATHS, fields, normalize_dialog


def audit():
    count = 0
    for namespace, names in PATHS.items():
        for name in names:
            path = base.PACK / 'data' / namespace / 'function' / (name + '.mcfunction')
            text = path.read_text(encoding='utf-8')
            assert normalize_dialog(namespace, name, text) == text, (namespace, name, 'not idempotent')
            for line in text.splitlines():
                if 'dialog set value {' in line or 'dialog show @s {' in line:
                    obj = line[line.index('{'):]
                    keys = fields(obj)
                    assert obj[slice(*keys['after_action'])] == '"none"', path
                    for footer in ('exit_action', 'action'):
                        if footer in keys:
                            assert 'action' in fields(obj[slice(*keys[footer])]), (path, 'dead exit button')
                    count += 1
    guess = base.PACK / 'data/decrypto/function/guess'
    assert 'after_action:"none"' in (guess / 'render.mcfunction').read_text(encoding='utf-8')
    assert 'dialog clear' not in (guess / 'handle.mcfunction').read_text(encoding='utf-8').split('matches 91')[0]
    print(f'Continuous dialog audit: {count} templates; regeneration and Decrypto digit selection checked', flush=True)


def macros(line):
    """按宏在组件中的位置生成codec探针数据，不触发任何真实玩家窗口。"""
    values = {}
    quote = None
    i = 0
    while i < len(line):
        ch = line[i]
        if ch == '\\': i += 2; continue
        if ch in "\"'":
            if quote == ch: quote = None
            elif quote is None: quote = ch
        if line.startswith('$(', i):
            end = line.index(')', i)
            name = line[i+2:end]
            values[name] = 'test' if quote else [] if name in ('buttons', 'actions') else 2 if name == 'columns' else {'text': 'test'}
            i = end
        i += 1
    return values


class Fixtures(base.Fixtures):
    def case(self, name, commands):
        if name == 'real_reload': self.cursor_cases()
        super().case(name, commands)

    def cursor_cases(self):
        commands = self.setup()
        for namespace, names in sorted(PATHS.items()):
            for name in sorted(names):
                text = (base.PACK / 'data' / namespace / 'function' / (name + '.mcfunction')).read_text(encoding='utf-8')
                line = next((line for line in text.splitlines() if re.match(r'\$?dialog show @s ', line)), None)
                if line is None: continue
                storage = 'dialog_cursor_test:probe'
                if '$(dialog)' in line:
                    builder = 'dialog/open' if namespace == 'avalon' else 'ui/build'
                    source = (base.PACK / 'data' / namespace / 'function' / (builder + '.mcfunction')).read_text(encoding='utf-8')
                    obj = next(x for x in source.splitlines() if 'dialog set value {' in x)
                    commands += ['data modify storage ' + storage + ' dialog set value ' + obj.split('dialog set value ', 1)[1]]
                else:
                    commands += ['data merge storage ' + storage + ' ' + json.dumps(macros(line), ensure_ascii=False)]
                commands += [f'execute as {base.person(1)} run function {namespace}:{name} with storage {storage}']
        player = base.person(1)
        commands += [f'scoreboard players set {player} un_pick 3',
                     f'scoreboard players set {player} ct_ui_close 1',
                     f'execute as {player} run function cardtable:dialog/close',
                     f'execute store success score #close_exists ut run scoreboard players get {player} ct_ui_close']
        commands += self.score('#close_exists', 'ut', 0, 'dialog_exit_consumes_only_own_close_request')
        commands += self.score(player, 'un_pick', 3, 'dialog_exit_preserves_game_selection')
        commands += ['say DIALOG_CURSOR_CODECS_FINISHED']
        super().case('dialog_cursor_codecs', commands)


if __name__ == '__main__':
    audit()
    base.Fixtures = Fixtures
    sys.exit(base.main())
