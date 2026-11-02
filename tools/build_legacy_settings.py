"""十二个早期游戏设置的统一单页文本界面，保留玩法参数及完整值域。"""
from pathlib import Path
import json

PACK = Path(__file__).resolve().parents[1]
ROOT = PACK / 'data/cardtable/function/settings'


def numeric(key, label, low, high, default):
    return {'key': key, 'label': label, 'low': low, 'high': high, 'default': default}


def options(key, label, values, default=0):
    return {'key': key, 'label': label, 'choices': values, 'low': min(v for v, _ in values),
            'high': max(v for v, _ in values), 'default': default}


ON_OFF = [(0, '关闭'), (1, '开启')]
BOOK_FORM = [(0, '书本'), (1, '对话框（提交需 OP）')]
GAMES = {
    1: ('fast_card', 'Fast Card', '4 人，按设定小局数累计积分；无效按钮乱按惩罚可开关。', [
        numeric('fc_max', '比赛小局数', 1, 999, 5), options('fc_rule', '无效抢按立即判负', ON_OFF)]),
    2: ('liars_holdem', '赌命德州扑克', '固定规则：2～8 人，跟注、换牌和 ALL IN。没有独立玩法参数。', []),
    3: ('hanabi', '花火', '2～5 人合作接烟花。彩色风暴增加彩色 1～5 各一张，目标扩至六色；彩色只能用彩色提示。奖励牌共 6 张，具体效果见规则。', [
        numeric('hb_clue_max', '提示标记上限', 1, 32, 8), numeric('hb_strike_max', '允许失误次数', 1, 9, 3),
        options('hb_storm', '彩色风暴扩展', ON_OFF)]),
    4: ('abraca', '出包魔法师', '2～5 人；塔层分数跨局累计，达到目标分数获胜。', [numeric('ab_goal', '获胜分数', 1, 32, 8)]),
    5: ('bullshit', '瞎掰王', '固定规则：3～8 人，每人担任一次大聪明，每轮阅读 20 秒。没有独立玩法参数。', []),
    6: ('decrypto', '谍报风云', '3～8 人。固定组队按座位分队；三人模式随机选截密者并固定五轮。分队回合上限仅影响 4～8 人。普通玩家选书本；对话框提交需要加密者有 OP。', [
        options('dc_team_mode', '组队方式', [(0, '随机组队'), (1, '按座位组队')]),
        numeric('dc_round_limit', '分队回合上限', 1, 32, 8), options('dc_input', '提示输入方式', BOOK_FORM)]),
    7: ('critical_point', '临界点', '固定规则：3～6 人，安全线为 3×人数+2；危机后强制最终投票，全场一次主动投票。没有独立玩法参数。', []),
    8: ('wenfei', '问非所答', '2～8 人，按人数设置每人担任猜题者的次数。普通玩家选书本；对话框提交需要回答者有 OP。', [
        numeric('wq_duo', '双人局每人猜题次数', 1, 6, 3), numeric('wq_multi', '多人局每人猜题次数', 1, 6, 2),
        options('wq_input', '答案输入方式', BOOK_FORM)]),
    9: ('skull', '骷髅牌', '固定规则：2～6 人，每人 3 张花牌和 1 张骷髅牌；成功挑战两次或成为唯一存活者获胜。没有独立玩法参数。', []),
    10: ('doudizhu', '斗地主', '1～3 名真人，空位补测试人机。每局累计积分，完成设定局数后结算；全员不叫重新发牌，不计一局。不洗牌模式首副成组，打散四张／连炸／同花团。', [
        numeric('dd_max', '比赛局数', 1, 32, 1), options('dd_audio', '游戏音乐', ON_OFF, 1),
        options('dd_bidmode', '叫地主模式', [(0, '叫分制'), (1, '叫抢制'), (2, '手速制')]),
        options('dd_counts', '显示剩余牌数', [(0, '隐藏'), (1, '显示')], 1),
        options('dd_counter', '记牌器', ON_OFF), options('dd_noshuffle', '洗牌模式', [(0, '正常洗牌'), (1, '不洗牌（多炸弹）')])]),
    16: ('avalon', '阿瓦隆', '固定规则：5～8 人，仅八座桌。开局前腾空快捷栏第 1、2、8 格；没有独立玩法参数。', []),
    19: ('ito', '命悬一线', '2～8 人，每轮随机一题；不自动弹窗。书本第一页填描述后 Q 提交；对话框模式使用第九格紫色染料，自行打开手牌并修改描述。普通玩家选书本，文字对话框提交需要 OP。', [
        options('it_input', '答案输入方式', BOOK_FORM)]),
}
LEGACY_TRIGGERS = ['fc_settings', 'hb_settings', 'ab_settings', 'dc_settings', 'wq_settings', 'dd_settings', 'it_settings']
OBJECTIVES = {key: 'dummy' for key in 'ct_st_nonce ct_st_table ct_st_game ct_st_load ct_st_seen ct_st_seat'.split()}
OBJECTIVES['ct_setting'] = 'trigger'


def js(value):
    return json.dumps(value, ensure_ascii=False, separators=(',', ':'))


def build():
    def put(name, text):
        path = ROOT / (name + '.mcfunction')
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes((text.strip() + '\n').encode('utf-8'))

    put('load', '\n'.join(f'scoreboard objectives add {key} {value}' for key, value in OBJECTIVES.items()) + '''
scoreboard players add #setting_load ct_ctx 1
execute unless score #setting_serial ct_ctx matches 1..9999 run scoreboard players set #setting_serial ct_ctx 1
scoreboard players set #setting_scale ct_ctx 100000
scoreboard players set #setting_thousand ct_ctx 1000
scoreboard players reset * ct_setting
scoreboard players reset * ct_st_nonce
''' + '\n'.join(f'scoreboard objectives add {trigger} trigger\nscoreboard players reset * {trigger}' for trigger in LEGACY_TRIGGERS))
    put('clear_session', '\n'.join(f'scoreboard players reset @s {key}' for key in OBJECTIVES))
    put('open', '''
execute unless score @s ct_state matches 0 run return 0
execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
scoreboard players operation #setting_table ct_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,limit=1] ct_id = #setting_table ct_ctx run return 0
function cardtable:chairs/layout/ensure
execute unless score @s ct_ch_epoch matches 0.. run scoreboard players set @s ct_ch_epoch 0
scoreboard players add #setting_serial ct_ctx 1
execute if score #setting_serial ct_ctx matches 10000.. run scoreboard players add #setting_load ct_ctx 1
execute if score #setting_serial ct_ctx matches 10000.. run scoreboard players set #setting_serial ct_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ct_st_nonce = #setting_serial ct_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ct_st_load = #setting_load ct_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ct_st_table = @s ct_id
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ct_st_game = @s ct_game
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ct_st_seen = @s ct_ch_epoch
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ct_st_seat = @a[tag=ct.settings_actor,limit=1] ct_seat
scoreboard players set @a[tag=ct.settings_actor,limit=1] ct_setting 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] ct_setting
''' + '\n'.join(f'scoreboard players reset @a[tag=ct.settings_actor,limit=1] {trigger}' for trigger in LEGACY_TRIGGERS) + '''
scoreboard players operation #setting_base ct_ctx = #setting_serial ct_ctx
scoreboard players operation #setting_base ct_ctx *= #setting_scale ct_ctx
execute store result storage cardtable:settings close int 1 run scoreboard players get #setting_base ct_ctx
''' + '\n'.join(f'execute if score @s ct_game matches {game} run return run function cardtable:settings/render_{game}' for game in GAMES))
    put('choice', '''
$data modify storage cardtable:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #setting_code ct_ctx $(value)
scoreboard players operation #setting_code ct_ctx += #setting_fieldbase ct_ctx
execute store result storage cardtable:settings code int 1 run scoreboard players get #setting_code ct_ctx
$execute unless score #setting_current ct_ctx matches $(value) run function cardtable:settings/command with storage cardtable:settings
$execute if score #setting_current ct_ctx matches $(value) run data modify storage cardtable:settings option.color set value "gold"
$execute if score #setting_current ct_ctx matches $(value) run data modify storage cardtable:settings option.bold set value true
$data modify storage cardtable:settings field$(field).extra append from storage cardtable:settings option
''')
    put('command', '$data modify storage cardtable:settings option.click_event set value {action:"run_command",command:"trigger ct_setting set $(code)"}')
    put('current', '''
$data modify storage cardtable:settings option set value {text:" $(current) ",color:"gold",bold:true}
$data modify storage cardtable:settings field$(field).extra append from storage cardtable:settings option
''')
    put('numeric_choice', '''
$scoreboard players set #setting_target ct_ctx $(delta)
scoreboard players operation #setting_target ct_ctx += #setting_current ct_ctx
execute if score #setting_target ct_ctx < #setting_low ct_ctx run scoreboard players operation #setting_target ct_ctx = #setting_low ct_ctx
execute if score #setting_target ct_ctx > #setting_high ct_ctx run scoreboard players operation #setting_target ct_ctx = #setting_high ct_ctx
execute if score #setting_target ct_ctx = #setting_current ct_ctx run return 0
$data modify storage cardtable:settings option set value {text:" [$(label)] ",color:"aqua"}
scoreboard players operation #setting_code ct_ctx = #setting_target ct_ctx
scoreboard players operation #setting_code ct_ctx += #setting_fieldbase ct_ctx
execute store result storage cardtable:settings code int 1 run scoreboard players get #setting_code ct_ctx
function cardtable:settings/command with storage cardtable:settings
$data modify storage cardtable:settings field$(field).extra append from storage cardtable:settings option
''')
    put('handle', '''
scoreboard players operation #setting_input ct_ctx = @s ct_setting
scoreboard players reset @s ct_setting
execute unless entity @s[tag=ct.player] run return 0
execute unless score @s ct_st_load = #setting_load ct_ctx run return run function cardtable:settings/invalid
execute unless score @s ct_st_table = @s ct_id run return run function cardtable:settings/invalid
execute unless score @s ct_st_seat = @s ct_seat run return run function cardtable:settings/invalid
execute unless score #setting_input ct_ctx matches 100000..999999999 run return run function cardtable:settings/invalid
scoreboard players operation #setting_nonce ct_ctx = #setting_input ct_ctx
scoreboard players operation #setting_nonce ct_ctx /= #setting_scale ct_ctx
execute unless score #setting_nonce ct_ctx = @s ct_st_nonce run return run function cardtable:settings/invalid
scoreboard players operation #setting_field ct_ctx = #setting_input ct_ctx
scoreboard players operation #setting_field ct_ctx %= #setting_scale ct_ctx
scoreboard players operation #setting_value ct_ctx = #setting_field ct_ctx
scoreboard players operation #setting_field ct_ctx /= #setting_thousand ct_ctx
scoreboard players operation #setting_value ct_ctx %= #setting_thousand ct_ctx
scoreboard players operation #setting_table ct_ctx = @s ct_st_table
tag @e[tag=ct.setting_controller] remove ct.setting_controller
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0}] if score @s ct_id = #setting_table ct_ctx run tag @s add ct.setting_controller
execute unless entity @e[tag=ct.setting_controller,limit=1] run return run function cardtable:settings/invalid
execute unless score @s ct_st_game = @e[tag=ct.setting_controller,limit=1] ct_game run return run function cardtable:settings/invalid
execute unless score @s ct_st_seen = @e[tag=ct.setting_controller,limit=1] ct_ch_epoch run return run function cardtable:settings/invalid
scoreboard players reset @s ct_st_nonce
execute if score #setting_field ct_ctx matches 0 if score #setting_value ct_ctx matches 0 run return run function cardtable:settings/close
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
execute as @e[tag=ct.setting_controller,limit=1] at @s run function cardtable:settings/apply
tag @s remove ct.settings_actor
tag @e[tag=ct.setting_controller] remove ct.setting_controller
''')
    put('invalid', '''
tellraw @s {text:"[牌桌] 游戏设置已过期，请重新打开。",color:"yellow"}
function cardtable:settings/clear_session
tag @e[tag=ct.setting_controller] remove ct.setting_controller
''')
    put('close', '''
dialog clear @s
function cardtable:settings/clear_session
tag @e[tag=ct.setting_controller] remove ct.setting_controller
''')
    put('apply', '\n'.join(f'execute if score @s ct_game matches {game} run return run function cardtable:settings/apply_{game}' for game in GAMES))
    for game, (namespace, title, description, fields) in GAMES.items():
        commands = []
        for index, field in enumerate(fields, 1):
            key, low, high = field['key'], field['low'], field['high']
            commands += [f'execute unless score @s {key} matches {low}..{high} run scoreboard players set @s {key} {field["default"]}',
                         f'scoreboard players operation #setting_current ct_ctx = @s {key}',
                         f'data modify storage cardtable:settings field{index} set value ' + js({'text': field['label'] + '：', 'color': 'gray', 'extra': []}),
                         f'scoreboard players set #setting_fieldbase ct_ctx {index * 1000}',
                         'scoreboard players operation #setting_fieldbase ct_ctx += #setting_base ct_ctx']
            if 'choices' in field:
                commands += ['function cardtable:settings/choice ' + js({'field': index, 'value': value, 'label': label}) for value, label in field['choices']]
            else:
                commands += [f'data modify storage cardtable:settings field set value {index}',
                             'execute store result storage cardtable:settings current int 1 run scoreboard players get #setting_current ct_ctx',
                             f'scoreboard players set #setting_low ct_ctx {low}', f'scoreboard players set #setting_high ct_ctx {high}']
                if high - low >= 10:
                    commands += [f'function cardtable:settings/numeric_choice {{field:{index},delta:-10,label:"−10"}}']
                commands += [
                             f'function cardtable:settings/numeric_choice {{field:{index},delta:-1,label:"−1"}}',
                             'function cardtable:settings/current with storage cardtable:settings',
                             f'function cardtable:settings/numeric_choice {{field:{index},delta:1,label:"+1"}}']
                if high - low >= 10:
                    commands += [f'function cardtable:settings/numeric_choice {{field:{index},delta:10,label:"+10"}}']
        commands += [f'function cardtable:settings/show_{game} with storage cardtable:settings']
        put('render_' + str(game), '\n'.join(commands))
        body = [{'type': 'minecraft:plain_message', 'width': 440, 'contents': {'text': '【牌桌皮肤 · 点击选择】', 'color': 'aqua', 'underlined': True, 'click_event': {'action': 'run_command', 'command': 'trigger ct_skin_pick set 4'}}},
                {'type': 'minecraft:plain_message', 'width': 440, 'contents': {'text': '【椅子数量 · 点击调整】', 'color': 'aqua', 'underlined': True, 'click_event': {'action': 'run_command', 'command': 'trigger ct_chair_pick set 1'}}}]
        body += [{'type': 'minecraft:plain_message', 'width': 440, 'contents': f'__field{index}__'} for index in range(1, len(fields) + 1)]
        body += [{'type': 'minecraft:plain_message', 'width': 440, 'contents': {'text': description, 'color': 'gray'}}]
        dialog = {'type': 'minecraft:notice', 'title': {'text': title + ' · 游戏设置', 'color': 'gold'}, 'body': body,
                  'action': {'label': {'text': '完成'}, 'width': 140, 'action': {'type': 'minecraft:run_command', 'command': 'trigger ct_setting set $(close)'}},
                  'pause': False, 'can_close_with_escape': True, 'after_action': 'none'}
        encoded = js(dialog)
        for index in range(1, len(fields) + 1):
            encoded = encoded.replace(f'"__field{index}__"', f'$(field{index})')
        put('show_' + str(game), '$dialog show @a[tag=ct.settings_actor,limit=1] ' + encoded)
        lines = []
        for index, field in enumerate(fields, 1):
            lines += [f'execute if score #setting_field ct_ctx matches {index} unless score #setting_value ct_ctx matches {field["low"]}..{field["high"]} run return 0']
        lines += [f'execute unless score #setting_field ct_ctx matches 1..{len(fields)} run return 0'] if fields else ['return 0']
        for index, field in enumerate(fields, 1):
            lines += [f'execute if score #setting_field ct_ctx matches {index} run scoreboard players operation @s {field["key"]} = #setting_value ct_ctx']
        if fields:
            lines += ['scoreboard players add @s ct_ch_epoch 1', 'function cardtable:settings/open']
        put('apply_' + str(game), '\n'.join(lines))

    # 外壳同时覆盖手写游戏；后续游戏生成器经normalize_settings_file保留相同路由。
    from table_chair_settings import normalize_settings_file
    for game, (namespace, _, _, _) in GAMES.items():
        folder = PACK / 'data' / namespace / 'function/settings'
        for path in folder.glob('*.mcfunction'):
            old = path.read_text(encoding='utf-8')
            new = normalize_settings_file(path, old)
            if new != old:
                path.write_bytes((new.rstrip() + '\n').encode('utf-8'))


if __name__ == '__main__':
    build()
