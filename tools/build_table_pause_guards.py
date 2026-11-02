"""统一的按桌暂停护栏；不覆盖游戏生成器生成的规则或清理逻辑。

在重新生成任意游戏后运行本工具。所有游戏仍使用各自的状态机；只在
外部输入和逐刻驱动入口阻止暂停桌继续推进，不改变状态编号或计时值。
"""
from pathlib import Path
import json
import re
from functools import lru_cache

PACK = Path(__file__).resolve().parents[1]
DATA = PACK / 'data'
GAMES = {
    'fast_card': 'fc', 'liars_holdem': 'lh', 'hanabi': 'hb',
    'abraca': 'ab', 'bullshit': 'bw', 'decrypto': 'dc',
    'critical_point': 'cp', 'wenfei': 'wq', 'skull': 'sk',
    'doudizhu': 'dd', 'uno': 'un', 'chess': 'ch',
    'xiangqi': 'xq', 'gomoku': 'gm', 'aeroplane_chess': 'ac',
    'avalon': 'av', 'love_letter': 'll', 'guandan': 'gd',
    'ito': 'it', 'weiqi': 'go', 'catan': 'ca',
}
BEGIN = '# table-pause: begin (tools/build_table_pause_guards.py)'
END = '# table-pause: end'
SELF_GUARD = [
    BEGIN,
    'execute if score @s ct_paused matches 1 run return 0',
    'execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0',
    'execute on origin if score @s ct_paused matches 1 run return 0',
    END,
]
BRANCH_GUARD = ' unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return]'


def emit(name, lines):
    path = DATA / 'cardtable/function/session' / (name + '.mcfunction')
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(('\n'.join(lines) + '\n').encode('utf-8'))


def strip_guards(text):
    text = re.sub(re.escape(BEGIN) + r'\n.*?\n' + re.escape(END) + r'\n?', '', text, flags=re.S)
    return text.replace(BRANCH_GUARD, '')


def guard_branches(line):
    """插在每次 as 后，保障全局 tick 中直接减 timer 也按本桌暂停。"""
    if not line.lstrip('$').startswith('execute '):
        return line
    positions = []
    for match in re.finditer(r'\bas (@[aeprs])', line):
        end = match.end()
        if end < len(line) and line[end] == '[':
            depth, quoted, escaped = 0, None, False
            for end in range(end, len(line)):
                char = line[end]
                if quoted:
                    if escaped: escaped = False
                    elif char == '\\': escaped = True
                    elif char == quoted: quoted = None
                elif char in ('"', "'"): quoted = char
                elif char == '[': depth += 1
                elif char == ']':
                    depth -= 1
                    if depth == 0:
                        end += 1
                        break
        positions.append(end)
    for end in reversed(positions):
        line = line[:end] + BRANCH_GUARD + line[end:]
    return line


def is_input_entry(name):
    # 清空、回收等函数也会由管理员中止和会话清理调用，必须保持可用。
    leaf = name.rsplit('/', 1)[-1]
    if leaf in ('clear', 'give', 'give_tools', 'sync', 'restore') or leaf.startswith(('clear_', 'invalidate', 'reset_', 'restore_', 'give_', 'refresh_')):
        return False
    return name.startswith(('input/', 'action/', 'ui/', 'click/', 'button/', 'red/',
                            'vote/handle', 'swap/apply', 'prompt/', 'question/open'))


def is_driver(name):
    leaf = name.rsplit('/', 1)[-1]
    return (leaf == 'tick' or leaf.endswith('_tick') or leaf.startswith('tick_')
            or leaf in ('maintenance', 'maintenance_one', 'heartbeat',
                        'check_online', 'check_session', 'recover_orphan_player'))


def is_global_driver(name):
    return name in ('tick', 'input/tick', 'system/tick_dimension', 'music/tick')


@lru_cache(None)
def saved_entries(namespace):
    path = PACK / 'tools/table_pause_guard_manifest.json'
    if not path.exists(): return set()
    return set(json.loads(path.read_text(encoding='utf-8')).get(namespace, []))


def rules_text(text):
    pause = '玩家离线后暂停，等待重新上线；其间可投票结束或由管理员中止。'
    for old, new in {
        '有人离线则结束本场。': pause,
        '有人离线时暂停操作，持续 200 刻则中止；': '有人离线后暂停，等待上线或结束游戏；',
        '玩家离线会中止本场并返回大厅；': '玩家离线后暂停，等待上线或结束游戏；',
        '玩家离线会中止本场。': pause,
        '离桌或离线中止整场，': '主动离桌中止整场；离线则暂停等待上线或结束游戏，',
        '离线或离桌中止整场。': '主动离桌中止整场；离线则暂停，等待上线或结束游戏。',
        '玩家离线则中止整场并回大厅；': '玩家离线后暂停，等待上线或结束游戏；',
        '玩家离线中止本局。': pause,
    }.items(): text = text.replace(old, new)
    return text


def remove_legacy_offline(name, lines):
    if name in ('game/maintenance', 'system/maintenance', 'system/maintenance_one',
                'system/heartbeat', 'system/check_online', 'game/tick', 'game/player_left'):
        lines = [l for l in lines if not (
            re.search(r'#[a-z_]*online[a-z_]*\b', l)
            and re.search(r'run (?:return run )?(?:function [a-z_]+:(?:game/(?:abort|player_left)|system/offline_seat)|tellraw)', l)
        )]
    if name == 'system/check_seat':
        lines = [l for l in lines if 'function liars_holdem:system/offline_seat' not in l]
    if name == 'game/tick':
        # 卡坦岛旧200刻离线超时被公共会话的无限期暂停取代。
        lines = [l for l in lines if not re.search(r'ca_offline|unless score #live ca_ctx = #required ca_ctx', l)]
    return lines


def augment(namespace, name, text, extra_entries=()):
    clean = strip_guards(text)
    if name.startswith('rules/'): clean = rules_text(clean)
    lines = remove_legacy_offline(name, clean.splitlines())
    if namespace == 'ito' and name in ('load', 'system/tick_dimension'):
        # ITO按三个维度分别驱动；无距离约束的@e会跨维度选取，导致每桌推进三次。
        lines = [l.replace('as @e[', 'as @e[distance=0..,') if (
            (name == 'system/tick_dimension' or l.startswith('execute in '))
            and 'as @e[' in l and 'as @e[distance=0..,' not in l) else l for l in lines]
    if namespace == 'weiqi' and name == 'system/reload':
        lines = [l.replace('execute if score @s go_state matches 2 ', 'execute unless score @s ct_paused matches 1 if score @s go_state matches 2 ') for l in lines]
    if namespace == 'catan' and name == 'system/reload':
        lines = ['execute unless score @s ct_paused matches 1 run ' + l if l in (
            'scoreboard players set @s ca_anim 0', 'data remove entity @s data.catan.visual_events') else l for l in lines]
        lines = [l.replace('function catan:visual/refresh', 'execute unless score @s ct_paused matches 1 run function catan:visual/refresh') if l == 'function catan:visual/refresh' else l for l in lines]
        lines = [l.replace('execute unless score @s ca_state matches 11', 'execute unless score @s ct_paused matches 1 unless score @s ca_state matches 11') if l.startswith('execute unless score @s ca_state matches 11') else l for l in lines]
    if is_global_driver(name): lines = [guard_branches(l) for l in lines]
    apply = is_input_entry(name) or is_driver(name) or name in extra_entries or name in saved_entries(namespace)
    # 旧manifest里可能包含已豁免的恢复函数；新的标准以豁免列表为准。
    leaf = name.rsplit('/', 1)[-1]
    if name.startswith('input/') and not is_input_entry(name) and not is_driver(name): apply = False
    if apply:
        insert = 0
        for index, line in enumerate(lines):
            if line.startswith('advancement revoke @s '): insert = index + 1
        lines[insert:insert] = SELF_GUARD
    return '\n'.join(lines) + '\n', apply


def write_guarded(path, text, *args, **kwargs):
    """供每个游戏生成器写入：重复生成时自动保留暂停规则和入口保护。"""
    path = Path(path)
    parts = path.parts
    if 'data' in parts and 'function' in parts and path.suffix == '.mcfunction':
        pos = parts.index('data')
        if pos + 2 < len(parts) and parts[pos + 1] in GAMES and parts[pos + 2] == 'function':
            name = '/'.join(parts[pos + 3:])[:-11]
            text, _ = augment(parts[pos + 1], name, text)
            if name.startswith('settings/'):
                from table_chair_settings import normalize_settings_file
                text = normalize_settings_file(path, text)
            if name in ('rules/show', 'rules/show_dialog', 'rules/open', 'rules/player'):
                from build_game_rules import normalize_rule_output
                text = normalize_rule_output(path, text)
            text = text.rstrip('\r\n') + '\n'
    kwargs.setdefault('newline', '\n')
    with path.open('w', *args, **kwargs) as output:
        return output.write(text)


def game_guards():
    changed, manifest = 0, {}
    for namespace in GAMES:
        root = DATA / namespace / 'function'
        entries = set()
        # 进度入口必须撤销自身后再阻止输入，避免暂停期间点一次导致以后失效。
        for path in (DATA / namespace / 'advancement').rglob('*.json'):
            reward = json.loads(path.read_text(encoding='utf-8')).get('rewards', {}).get('function', '')
            if reward.startswith(namespace + ':'):
                entries.add(reward.split(':', 1)[1])
        tick_targets = set()
        for path in root.rglob('*.mcfunction'):
            name = path.relative_to(root).as_posix()[:-11]
            if is_global_driver(name):
                tick_targets.update(re.findall(r'\bfunction ' + re.escape(namespace) + r':([a-z0-9_/]+)', path.read_text(encoding='utf-8')))
        entries.update(n for n in tick_targets if not n.startswith(('settings/', 'rules/', 'player/clear', 'game/init_table', 'game/return_lobby')))
        guarded = []
        for path in root.rglob('*.mcfunction'):
            name = path.relative_to(root).as_posix()[:-11]
            original = path.read_text(encoding='utf-8')
            result, apply = augment(namespace, name, original, entries)
            if apply: guarded.append(name)
            if result != original:
                path.write_bytes(result.encode('utf-8'))
                changed += 1
        manifest[namespace] = sorted(guarded)
    return changed, manifest


def discard_inputs():
    """controller 每个暂停刻调用。不会处理牌桌的结束投票或管理员命令。"""
    resets = set()
    for namespace in GAMES:
        for path in (DATA / namespace / 'function').rglob('*.mcfunction'):
            resets.update(re.findall(r'^scoreboard objectives add (\S+) (?:trigger|minecraft\.dropped:\S+)\s*$', path.read_text(encoding='utf-8'), re.M))
    emit('discard_paused_player_inputs', [
        '# @s 为暂停桌的在线玩家；只清本游戏输入，不修改 ct_voted 等公共结束投票。',
        *[f'execute if score @s {obj} matches 1.. run scoreboard players set @s {obj} 0' for obj in sorted(resets)],
        '# F键不会增加Q统计；副手中的游戏道具必须换回，防止恢复后补出牌/跟注。',
        'scoreboard players set #pause_offhand ct_id 0',
        *[f'execute if items entity @s weapon.offhand *[minecraft:custom_data~{{{namespace}:{{}}}}] run scoreboard players set #pause_offhand ct_id 1' for namespace in GAMES],
        'execute if score #pause_offhand ct_id matches 1 run function cardtable:session/return_paused_offhand',
        '# 暂停期间丢出的道具完整复制回空槽，不补执行游戏操作。',
        'execute at @s as @e[type=minecraft:item,distance=..6,tag=!ct.paused_return] run function cardtable:session/check_paused_drop',
    ])
    emit('discard_paused_inputs', [
        '# @s 为 ct_paused=1 的控制器；在所有游戏 tick 前调用。',
        'scoreboard players operation #pause_table ct_id = @s ct_id',
        'execute as @a[tag=ct.player,scores={ct_paused=1}] if score @s ct_id = #pause_table ct_id run function cardtable:session/discard_paused_player_inputs',
        '# 只丢弃游戏点击，ct.vote / ct.rules / ct.seat 等公共交互完全保留。',
        *[f'execute at @s as @e[type=minecraft:interaction,distance=..6,tag=!ct.vote,tag=!ct.rules,tag=!ct.seat,tag=!ct.menu] if data entity @s {field} run function cardtable:session/check_paused_interaction' for field in ('interaction', 'attack')],
    ])
    emit('check_paused_interaction', [
        '# 新游戏用 ct_id，早期游戏用 prefix_id；只匹配暂停的本桌。',
        *[f'execute if score @s {objective} = #pause_table ct_id run return run function cardtable:session/discard_game_click' for objective in ['ct_id'] + [p + '_id' for p in GAMES.values()]],
    ])
    emit('discard_game_click', ['data remove entity @s interaction', 'data remove entity @s attack'])
    emit('check_paused_drop', [
        '# @s 是玩家附近的一件掉落物，只回收原主属于本暂停桌的游戏道具。',
        'tag @s remove ct.pause_candidate',
        *[f'execute if items entity @s contents *[minecraft:custom_data~{{{namespace}:{{}}}}] run tag @s add ct.pause_candidate' for namespace in GAMES],
        'execute unless entity @s[tag=ct.pause_candidate] run return 0',
        'tag @s remove ct.pause_candidate',
        'execute on origin if entity @s[type=minecraft:player,tag=ct.player,scores={ct_paused=1}] if score @s ct_id = #pause_table ct_id run tag @s add ct.pause_owner',
        'execute unless entity @a[tag=ct.pause_owner,limit=1] run return 0',
        'tag @s add ct.pause_candidate',
        'tag @s add ct.paused_return',
        'execute on origin run function cardtable:session/return_paused_drop',
        'tag @s remove ct.pause_candidate',
        'tag @a[tag=ct.pause_owner] remove ct.pause_owner',
    ])
    slots = [f'hotbar.{i}' for i in range(9)] + [f'inventory.{i}' for i in range(27)] + ['weapon.offhand']
    emit('return_paused_drop', [
        '# @s 是真实原主；不覆盖原有物品、不改变道具组件或牌面。',
        *[f'execute unless items entity @s {slot} * run return run function cardtable:session/return_paused_drop_slot {{slot:"{slot}"}}' for slot in slots],
        '# 满背包时保留实体并允许立即拾回；ct.paused_return 禁止其成为延迟输入。',
        'data merge entity @e[type=minecraft:item,tag=ct.pause_candidate,limit=1] {PickupDelay:0s,Age:0s}',
        'execute at @s run tp @e[type=minecraft:item,tag=ct.pause_candidate,limit=1] ~ ~ ~',
    ])
    emit('return_paused_drop_slot', [
        '$item replace entity @s $(slot) from entity @e[type=minecraft:item,tag=ct.pause_candidate,limit=1] contents',
        'kill @e[type=minecraft:item,tag=ct.pause_candidate,limit=1]',
    ])
    emit('return_paused_offhand', [
        'execute if items entity @s weapon.mainhand * run return run function cardtable:session/swap_paused_hands',
        'item replace entity @s weapon.mainhand from entity @s weapon.offhand',
        'item replace entity @s weapon.offhand with minecraft:air',
    ])
    emit('swap_paused_hands', [
        '# 两手都有物品时只交换，绝不覆盖玩家原本的副手物品。',
        'summon minecraft:item ~ ~ ~ {Tags:["ct.pause_swap"],Item:{id:"minecraft:stone",count:1},PickupDelay:32767s}',
        'item replace entity @e[type=minecraft:item,tag=ct.pause_swap,limit=1] contents from entity @s weapon.mainhand',
        'item replace entity @s weapon.mainhand from entity @s weapon.offhand',
        'item replace entity @s weapon.offhand from entity @e[type=minecraft:item,tag=ct.pause_swap,limit=1] contents',
        'kill @e[type=minecraft:item,tag=ct.pause_swap]',
    ])


def main():
    changed, manifest = game_guards()
    discard_inputs()
    report = PACK / 'tools/table_pause_guard_manifest.json'
    report.write_bytes((json.dumps(manifest, ensure_ascii=False, indent=2) + '\n').encode('utf-8'))
    print(f'暂停护栏：{len(GAMES)} 个游戏，{sum(map(len, manifest.values()))} 个入口；更新 {changed} 个函数。')


if __name__ == '__main__':
    main()
