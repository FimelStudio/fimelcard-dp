"""CATAN: one-page immediate settings and concise player rules.

Ordinary players submit trigger values; the server binds every action to the
player, table, lobby epoch, reload generation and a one-use window nonce.
"""
from pathlib import Path
import json

PACK = Path(__file__).resolve().parents[1]
ROOT = PACK / 'data/catan/function'
FIELDS = [
    (1, 'layout', '岛屿布局', [(0, '推荐布局'), (1, '随机布局')]),
    (2, 'orient', '棋盘方向', [(0, '默认方向'), (1, '旋转 90°')]),
    (3, 'first', '首位行动', [(0, '随机'), (1, '按座位')]),
    (4, 'music', '背景音乐', [(0, '关闭'), (1, '开启')]),
]
OBJECTIVES = {'ca_settings': 'trigger', 'ca_setnonce': 'dummy', 'ca_setload': 'dummy',
    'ca_settable': 'dummy', 'ca_setepoch': 'dummy',
    **{'ca_' + key: 'dummy' for _, key, _, _ in FIELDS}}


def build(root=ROOT):
    def put(name, lines):
        path = root / (name + '.mcfunction')
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(('\n'.join(lines) if isinstance(lines, list) else lines).strip() + '\n', encoding='utf-8')
    def js(value):
        return json.dumps(value, ensure_ascii=False, separators=(',', ':'))
    put('settings/load', [
        '# ca_ctx is installed by catan:load before this hook.',
        'scoreboard players add #settings_load ca_ctx 1',
        'execute as @a run function catan:settings/clear_session'])
    put('settings/defaults', [
        f'execute unless score @s ca_{key} matches 0..1 run scoreboard players set @s ca_{key} {1 if key == "music" else 0}'
        for _, key, _, _ in FIELDS])
    put('settings/open', '''
execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
execute unless score @s ct_game matches 21 run return 0
execute unless score @s ct_state matches 0 run return 0
scoreboard players operation #set_table ca_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,tag=ct.player,limit=1] ct_id = #set_table ca_ctx run return 0
function catan:settings/defaults
function catan:settings/begin
function catan:settings/root
''')
    put('settings/begin', '''
execute if score #settings_serial ca_ctx matches 99999.. run scoreboard players add #settings_load ca_ctx 1
execute unless score #settings_serial ca_ctx matches 9999..99998 run scoreboard players set #settings_serial ca_ctx 9999
scoreboard players add #settings_serial ca_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ca_setnonce = #settings_serial ca_ctx
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ca_setload = #settings_load ca_ctx
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ca_settable = @s ct_id
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ca_setepoch = @s ca_epoch
scoreboard players set @a[tag=ct.settings_actor,tag=ct.player,limit=1] ca_settings 0
scoreboard players enable @a[tag=ct.settings_actor,tag=ct.player,limit=1] ca_settings
scoreboard players set #set_scale ca_ctx 10000
scoreboard players operation #set_base ca_ctx = #settings_serial ca_ctx
scoreboard players operation #set_base ca_ctx *= #set_scale ca_ctx
execute store result storage catan:settings close int 1 run scoreboard players get #set_base ca_ctx
''' + '\n'.join(f'execute store result storage catan:settings {key} int 1 run scoreboard players get @s ca_{key}' for _, key, _, _ in FIELDS))
    lines = []
    for field, key, label, choices in FIELDS:
        lines.append('data modify storage catan:settings ' + key + '_row set value ' + js({'text': label + '\n', 'color': 'white', 'extra': []}))
        for value, choice in choices:
            lines.append('function catan:settings/choice ' + js({'key': key, 'value': value, 'code': field * 100 + value, 'label': choice}))
    put('settings/root', lines + ['function catan:settings/root_show with storage catan:settings'])
    put('settings/choice', '''
$execute store result score #set_current ca_ctx run data get storage catan:settings $(key)
$data modify storage catan:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #set_code ca_ctx $(code)
scoreboard players operation #set_code ca_ctx += #set_base ca_ctx
execute store result storage catan:settings code int 1 run scoreboard players get #set_code ca_ctx
$execute unless score #set_current ca_ctx matches $(value) run function catan:settings/command with storage catan:settings
$execute if score #set_current ca_ctx matches $(value) run data modify storage catan:settings option.color set value "gold"
$execute if score #set_current ca_ctx matches $(value) run data modify storage catan:settings option.bold set value true
$data modify storage catan:settings $(key)_row.extra append from storage catan:settings option
''')
    put('settings/command', '$data modify storage catan:settings option.click_event set value {action:"run_command",command:"trigger ca_settings set $(code)"}')
    dialog = {'type': 'minecraft:notice', 'title': {'text': '卡坦岛 · 游戏设置', 'color': 'gold'},
        'body': [{'type': 'minecraft:plain_message', 'width': 400, 'contents': {
            'text': '【牌桌皮肤 · 点击选择】', 'color': 'aqua', 'underlined': True,
            'click_event': {'action': 'run_command', 'command': 'trigger ct_skin_pick set 4'}}}] + [
            {'type': 'minecraft:plain_message', 'width': 400, 'contents': '__' + key + '__'} for _, key, _, _ in FIELDS],
        'action': {'label': {'text': '完成'}, 'width': 140, 'action': {
            'type': 'minecraft:run_command', 'command': 'trigger ca_settings set $(close)'}},
        'pause': False, 'can_close_with_escape': True, 'after_action': 'none'}
    body = js(dialog)
    for _, key, _, _ in FIELDS:
        body = body.replace('"__' + key + '__"', '$(' + key + '_row)')
    put('settings/root_show', '$dialog show @a[tag=ct.settings_actor,tag=ct.player,limit=1] ' + body)
    put('settings/invalid', '''
function catan:settings/clear_session
tellraw @s {text:"[卡坦岛] 设置窗口已过期，请重新打开。",color:"yellow"}
tag @e[tag=ca.setting_table] remove ca.setting_table
''')
    lines = '''
scoreboard players set #set_input ca_ctx 0
scoreboard players operation #set_input ca_ctx = @s ca_settings
scoreboard players reset @s ca_settings
execute unless entity @s[tag=ct.player] run return run function catan:settings/invalid
execute unless score @s ca_setload = #settings_load ca_ctx run return run function catan:settings/invalid
execute unless score @s ct_id = @s ca_settable run return run function catan:settings/invalid
execute unless score #set_input ca_ctx matches 100000000..999990401 run return run function catan:settings/invalid
scoreboard players set #set_scale ca_ctx 10000
scoreboard players set #set_hundred ca_ctx 100
scoreboard players operation #set_nonce ca_ctx = #set_input ca_ctx
scoreboard players operation #set_nonce ca_ctx /= #set_scale ca_ctx
execute unless score #set_nonce ca_ctx = @s ca_setnonce run return run function catan:settings/invalid
scoreboard players operation #set_field ca_ctx = #set_input ca_ctx
scoreboard players operation #set_field ca_ctx %= #set_scale ca_ctx
scoreboard players operation #set_field ca_ctx /= #set_hundred ca_ctx
scoreboard players operation #set_value ca_ctx = #set_input ca_ctx
scoreboard players operation #set_value ca_ctx %= #set_hundred ca_ctx
scoreboard players operation #set_table ca_ctx = @s ca_settable
scoreboard players operation #set_epoch ca_ctx = @s ca_setepoch
tag @e[tag=ca.setting_table] remove ca.setting_table
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=21,ct_state=0}] if score @s ct_id = #set_table ca_ctx if score @s ca_epoch = #set_epoch ca_ctx run tag @s add ca.setting_table
execute unless entity @e[tag=ca.setting_table,limit=1] run return run function catan:settings/invalid
execute unless score #set_field ca_ctx matches 0..4 run return run function catan:settings/invalid
execute if score #set_field ca_ctx matches 0 unless score #set_value ca_ctx matches 0 run return run function catan:settings/invalid
execute if score #set_field ca_ctx matches 1..4 unless score #set_value ca_ctx matches 0..1 run return run function catan:settings/invalid
scoreboard players reset @s ca_setnonce
execute if score #set_field ca_ctx matches 0 run return run function catan:settings/close
'''.strip().splitlines()
    for field, key, _, _ in FIELDS:
        lines.append(f'execute if score #set_field ca_ctx matches {field} run scoreboard players operation @e[tag=ca.setting_table,limit=1] ca_{key} = #set_value ca_ctx')
    lines += ['tag @a[tag=ct.settings_actor] remove ct.settings_actor', 'tag @s add ct.settings_actor',
        'execute if score #set_field ca_ctx matches 1..2 as @e[tag=ca.setting_table,limit=1] at @s run function catan:game/preview',
        'execute as @e[tag=ca.setting_table,limit=1] at @s run function catan:settings/open',
        'tag @a[tag=ct.settings_actor] remove ct.settings_actor', 'tag @e[tag=ca.setting_table] remove ca.setting_table']
    put('settings/save', lines)
    put('settings/clear_session', ['scoreboard players reset @s ca_' + key for key in ('settings', 'setnonce', 'setload', 'settable', 'setepoch')])
    put('settings/close', ['function catan:settings/clear_session', 'dialog clear @s',
        'tag @s remove ct.settings_actor', 'tag @e[tag=ca.setting_table] remove ca.setting_table'])
    put('settings/invalidate_table', ['scoreboard players operation #set_table ca_ctx = @s ct_id',
        'execute as @a if score @s ca_settable = #set_table ca_ctx run function catan:settings/clear_session'])
    paragraphs = [
        '3～4 人 · 黑色强盗与五种资源 · 本人回合达到 10 分获胜。村庄 1 分、城市 2 分，最长道路与最大军队各 2 分；胜利点开发牌保密。',
        '开局按顺序放一村一道，再逆序放第二组；仅第二个村庄领取相邻地形的起始资源。村庄之间至少隔一个空交点。',
        '本人回合先掷两骰；所有玩家按数字生产，村庄 1 张、城市 2 张。强盗地块停产。掷出 7 时，超过 7 张资源者须弃掉一半（向下取整），随后当前玩家移动强盗并偷一张相邻对手的随机资源。',
        '建路：木＋砖；建村：木＋砖＋羊毛＋麦；升级城市：麦×2＋矿×3；买开发牌：羊毛＋麦＋矿。每人最多 15 道路、5 村庄、4 城市。',
        '道路连接己方道路或建筑；不能穿过对手建筑。村庄须连接己方道路且相邻交点没有建筑；城市升级己方村庄。选位置后先预览，确认才支付。',
        '银行通常 4:1，通用港口 3:1，指定港口对应资源 2:1。玩家交易必须包含当前行动者；只能交易资源，不能赠送或同资源互换。回合外也能打开菜单接受或拒绝当前提议。',
        '每回合最多使用一张旧开发牌，可在掷骰前使用；本回合新买的非胜利点牌不能用。骑士移动强盗但不触发弃半；修路免费建最多两路；发明取两张资源；垄断收取所有对手某种资源。',
        '最长道路至少 5 段，同一路段只能经过一次，可以绕环和重复经过交点；对手建筑截断穿行。最大军队至少 3 张已用骑士；原持有者并列时保留奖励。',
        '手持第 1 格操作物按 Q，按准星选择远处目标；近处也能右键棋盘。第 9 格按 Q 打开资源、交易、开发牌与回合菜单。未确认的预选不扣资源。',
        '具体资源与未用开发牌仅本人可见。音乐可在设置／局内菜单切换，音量属于「唱片机／音符盒」。有人离线时暂停操作，持续 200 刻则中止；重载不重新投骰或重复发资源。',
    ]
    rules = {'type': 'minecraft:notice', 'title': {'text': '卡坦岛 · 规则与操作', 'color': 'gold'},
        'body': [{'type': 'minecraft:plain_message', 'width': 460, 'contents': {'text': p, 'color': 'white'}} for p in paragraphs],
        'action': {'label': {'text': '返回'}, 'width': 140}, 'pause': False, 'can_close_with_escape': True}
    put('rules/show', 'dialog show @a[tag=ct.rules_actor,limit=1] ' + js(rules))


if __name__ == '__main__':
    build()
