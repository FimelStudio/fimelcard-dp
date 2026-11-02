"""公共椅子设置行；游戏生成器与已维护的手写设置页共用，重复执行不叠加。"""
from pathlib import Path
import json
import re

PACK = Path(__file__).resolve().parents[1]
LEGACY = {'fast_card': 'fc_settings', 'liars_holdem': 'lh_settings', 'hanabi': 'hb_settings',
          'abraca': 'ab_settings', 'bullshit': 'bw_settings', 'decrypto': 'dc_settings',
          'critical_point': 'cp_settings', 'wenfei': 'wq_settings', 'skull': 'sk_settings',
          'doudizhu': 'dd_settings', 'avalon': 'av_settings', 'ito': 'it_settings'}


def row(label, command):
    return json.dumps({'type': 'minecraft:plain_message', 'width': 440,
                      'contents': {'text': label, 'color': 'aqua', 'underlined': True,
                                   'click_event': {'action': 'run_command', 'command': command}}},
                     ensure_ascii=False, separators=(',', ':'))


CHAIR_ROW = row('【椅子数量 · 点击调整】', 'trigger ct_chair_pick set 1')
SKIN_ROW = row('【牌桌皮肤 · 点击选择】', 'trigger ct_skin_pick set 4')


def augment_dialog(text):
    """在实际游戏设置 Dialog 的皮肤行后插入公共入口，保留现有 SNBT/宏。"""
    result = []
    for line in text.splitlines():
        is_dialog = 'dialog show' in line or ('data modify storage' in line and 'dialog set value' in line)
        if is_dialog and '设置' in line:
            line = re.sub(r'("width"\s*:\s*)(?:400|460|480)\b', r'\g<1>440', line)
        if not is_dialog or '设置' not in line or 'ct_chair_pick' in line:
            result.append(line)
            continue
        match = re.search(r'(?:"body"|body)\s*:\s*\[', line)
        if not match:
            result.append(line)
            continue
        begin = match.end()
        if 'ct_skin_pick' not in line:
            line = line[:begin] + SKIN_ROW + ',' + CHAIR_ROW + ',' + line[begin:]
        else:
            # 第一项为皮肤入口；尊重字符串内的括号和转义，不用贪婪正则截 JSON。
            depth, quoted, escape, end = 0, None, False, begin
            for index in range(begin, len(line)):
                char = line[index]
                if quoted:
                    if escape:
                        escape = False
                    elif char == '\\':
                        escape = True
                    elif char == quoted:
                        quoted = None
                elif char in ('"', "'"):
                    quoted = char
                elif char in '{[':
                    depth += 1
                elif char in '}]':
                    depth -= 1
                    if depth == 0:
                        end = index + 1
                        break
            line = line[:end] + ',' + CHAIR_ROW + line[end:]
        result.append(line)
    return '\n'.join(result)


def normalize_settings_file(path, text):
    """公共写入适配：早期游戏改走统一界面，旧保存编码不能重新启用。"""
    path = Path(path)
    parts = path.parts
    try:
        index = parts.index('data')
    except ValueError:
        return text
    if index + 4 >= len(parts) or parts[index + 2:index + 4] != ('function', 'settings'):
        return text
    namespace = parts[index + 1]
    if namespace not in LEGACY:
        return augment_dialog(text)
    if path.stem == 'save':
        return ('# 旧设置窗口编码已停用，新界面使用公共一次性会话。\n'
                f'scoreboard players reset @s {LEGACY[namespace]}\n'
                'tellraw @s {text:"[牌桌] 设置界面已更新，请重新打开游戏设置。",color:"yellow"}\nreturn 0\n')
    if path.stem == 'open' or ('dialog show' in text or 'dialog set value' in text):
        return '# 公共单页文本设置；保留本游戏的实际控制器参数。\nfunction cardtable:settings/open\n'
    return text


def patch_existing():
    changed = []
    for path in sorted((PACK / 'data').glob('*/function/settings/*.mcfunction')):
        old = path.read_text(encoding='utf-8')
        new = normalize_settings_file(path, old).rstrip() + '\n'
        if old != new:
            path.write_bytes(new.encode('utf-8'))
            changed.append(str(path.relative_to(PACK)))
    return changed


if __name__ == '__main__':
    print('\n'.join(patch_existing()))
