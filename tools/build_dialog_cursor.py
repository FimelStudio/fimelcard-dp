"""保留连续交互Dialog的鼠标位置，并给无回调的退出按钮补充自身关窗动作。"""
from pathlib import Path
import re

PACK = Path(__file__).resolve().parents[1]
PATHS = {
    'avalon': {'dialog/open', 'dialog/confirm_early', 'dialog/show'},
    'skull': {'ui/build', 'ui/show'},
    'love_letter': {'ui/show'},
    'catan': {'ui/show', 'ui/submit'},
    'weiqi': {'ui/show'},
    'chess': {'ui/actions_show'},
    'xiangqi': {'ui/actions_show'},
    'gomoku': {'ui/actions_show'},
    'hanabi': {
        'dialog/main/show', 'dialog/main/open', 'dialog/restore/open',
        'dialog/restore/show', 'dialog/hint/show_target', 'dialog/hint/show_choice',
        'dialog/discard/show', 'reward/full_hint/show_target',
        'reward/full_hint/show_card', 'reward/risk/show',
    },
}
CLOSE = '{type:"minecraft:run_command",command:"trigger ct_ui_close set 1"}'


def fields(s):
    """读取单行SNBT/JSON对象的顶层字段，跳过字符串和嵌套组件。"""
    result = {}
    i = 1
    while i < len(s) - 1:
        while s[i].isspace() or s[i] == ',': i += 1
        if s[i] == '}': break
        match = re.match(r'''(?:"([^"]+)"|'([^']+)'|([\w:]+))\s*:\s*''', s[i:])
        if not match: raise ValueError(s[i:i+80])
        key = next(x for x in match.groups() if x is not None)
        i += match.end()
        start = i
        depth, quote = 0, None
        while i < len(s):
            ch = s[i]
            if quote:
                if ch == '\\': i += 2; continue
                if ch == quote: quote = None
            elif ch in "\"'": quote = ch
            elif ch in '{[': depth += 1
            elif ch in '}]':
                if depth == 0: break
                depth -= 1
            elif ch == ',' and depth == 0: break
            i += 1
        result[key] = (start, i)
    return result


def put_field(obj, key, value):
    keys = fields(obj)
    if key in keys:
        start, end = keys[key]
        return obj[:start] + value + obj[end:]
    return obj[:-1].rstrip() + ',' + key + ':' + value + '}'


def keep_open(obj):
    obj = put_field(obj, 'after_action', '"none"')
    keys = fields(obj)
    kind = obj[slice(*keys['type'])].strip("\"'")
    footer = 'exit_action' if kind == 'minecraft:multi_action' else 'action'
    if footer in keys:
        button = obj[slice(*keys[footer])]
        if 'action' not in fields(button):
            obj = put_field(obj, footer, put_field(button, 'action', CLOSE))
    elif kind == 'minecraft:notice':
        obj = put_field(obj, 'action', '{label:{text:"返回游戏"},action:' + CLOSE + '}')
    return obj


def normalize_dialog(namespace, name, text):
    if name not in PATHS.get(namespace, set()): return text
    if (namespace, name) in {('catan', 'ui/submit'), ('hanabi', 'dialog/main/open'), ('hanabi', 'dialog/restore/open')}:
        text = text.replace('dialog clear @s\n', '')
    lines = []
    for line in text.splitlines():
        if 'dialog set value {' in line or ('dialog show @s {' in line):
            start = line.index('{')
            line = line[:start] + keep_open(line[start:])
        if re.match(r'\$?dialog show @s ', line):
            # Server-confirmed exit, separate from game inputs and their nonces.
            if not lines or lines[-1] != 'scoreboard players enable @s ct_ui_close':
                lines += ['scoreboard players set @s ct_ui_close 0', 'scoreboard players enable @s ct_ui_close']
        lines.append(line)
    return '\n'.join(lines) + '\n'


def install_runtime():
    root = PACK / 'data/cardtable/function'
    for name, body in [('load', 'scoreboard objectives add ct_ui_close trigger'),
                       ('tick', 'execute as @a[scores={ct_ui_close=1..}] run function cardtable:dialog/close')]:
        path = root / (name + '.mcfunction')
        text = path.read_text(encoding='utf-8')
        if body not in text:
            path.write_text(text.rstrip() + '\n# dialog-cursor: explicit self-close\n' + body + '\n', encoding='utf-8')
    path = root / 'dialog/close.mcfunction'
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text('# 仅关闭提交者自己的窗口，不分派游戏动作或改变选择。\nscoreboard players reset @s ct_ui_close\ndialog clear @s\n', encoding='utf-8')


def main():
    changed = []
    install_runtime()
    for namespace, names in PATHS.items():
        for name in sorted(names):
            path = PACK / 'data' / namespace / 'function' / (name + '.mcfunction')
            before = path.read_text(encoding='utf-8')
            after = normalize_dialog(namespace, name, before)
            if before != after:
                path.write_text(after, encoding='utf-8')
                changed.append(f'{namespace}:{name}')
    print('Updated continuous dialog paths: ' + ', '.join(changed))


if __name__ == '__main__': main()
