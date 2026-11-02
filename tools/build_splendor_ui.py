# -*- coding: utf-8 -*-
"""璀璨宝石：公共市场、私有预约及可精确选择黄金支付的无OP对话框。"""
import json
from build_splendor_game import put

NAMES = ['钻石', '蓝宝石', '祖母绿', '红宝石', '缟玛瑙', '黄金']
COLORS = ['white', 'blue', 'green', 'red', 'dark_gray', 'gold']


def js(value):
    return json.dumps(value, ensure_ascii=False, separators=(',', ':'))


def text(value, color='white'):
    return {'text': value, 'color': color}


def gems(prefix, size='small'):
    out = []
    for i, name in enumerate(NAMES):
        out += [{'text': chr(0xE980 + i), 'font': 'card:splendor/' + size, 'color': 'white'}, text(' $(' + prefix + str(i) + ')  ')]
    return out


def button(code, label, color='white', guard=None):
    cmd = 'function splendor:ui/button ' + js({'code': code, 'label': label, 'color': color})
    return 'execute ' + guard + ' run ' + cmd if guard else cmd


def main():
    put('ui/begin', '''
execute if score #panel_serial sp_ctx matches 99999.. run scoreboard players add #ui_load sp_ctx 1
execute unless score #panel_serial sp_ctx matches 1..99998 run scoreboard players set #panel_serial sp_ctx 1
scoreboard players add #panel_serial sp_ctx 1
scoreboard players operation @s sp_nonce = #panel_serial sp_ctx
scoreboard players operation @s sp_seen = @e[tag=sp.current,limit=1] sp_epoch
scoreboard players operation @s sp_ui_load = #ui_load sp_ctx
scoreboard players operation @s sp_ui_table = @s sp_table
scoreboard players operation #ui_base sp_ctx = @s sp_nonce
scoreboard players operation #ui_base sp_ctx *= #factor sp_ctx
scoreboard players set @s sp_action 0
scoreboard players enable @s sp_action
data modify storage splendor:ui buttons set value []
data modify storage splendor:ui detail set value {text:""}
data modify storage splendor:ui picture set value {text:""}
execute store result storage splendor:ui close int 1 run scoreboard players get #ui_base sp_ctx
function splendor:ui/summary
''')
    put('ui/button', '''
$scoreboard players set #ui_code sp_ctx $(code)
scoreboard players operation #ui_code sp_ctx += #ui_base sp_ctx
execute store result storage splendor:ui code int 1 run scoreboard players get #ui_code sp_ctx
$data modify storage splendor:ui label set value "$(label)"
$data modify storage splendor:ui color set value "$(color)"
function splendor:ui/button_append with storage splendor:ui
''')
    put('ui/button_append', '$data modify storage splendor:ui buttons append value {label:{text:"$(label)",color:"$(color)"},width:145,action:{type:"minecraft:run_command",command:"trigger sp_action set $(code)"}}')
    put('ui/show', '$dialog show @s {type:"minecraft:multi_action",title:{text:"$(title)",color:"gold"},body:[{type:"minecraft:plain_message",width:470,contents:$(public)},{type:"minecraft:plain_message",width:470,contents:$(private)},{type:"minecraft:plain_message",width:470,contents:$(picture)},{type:"minecraft:plain_message",width:470,contents:$(detail)}],columns:3,actions:$(buttons),exit_action:{label:{text:"返回牌桌"},action:{type:"minecraft:run_command",command:"trigger sp_action set $(close)"}},pause:false,can_close_with_escape:true,after_action:"none"}')
    put('ui/summary', '''
data modify storage splendor:ui title set value "璀璨宝石 · 市场"
data modify storage splendor:ui public set value {text:"",extra:[]}
execute store result storage splendor:ui side int 1 run scoreboard players get @s sp_side
function splendor:ui/private with storage splendor:ui
execute as @e[tag=sp.current,limit=1] run function splendor:ui/table_summary with entity @s data.splendor
function splendor:ui/bank_summary
''')
    put('ui/bank_summary', [f'data modify storage splendor:ui bank.t{i} set from entity @e[tag=sp.current,limit=1] data.splendor.bank[{i}]' for i in range(6)] + ['function splendor:ui/bank_append with storage splendor:ui bank'])
    put('ui/bank_append', '$data modify storage splendor:ui public.extra append value ' + js({'text':'','extra':[text('\n银行：','gray')]+gems('t')}))
    private = ['$data modify storage splendor:ui hand set from entity @e[tag=sp.current,limit=1] data.splendor.p$(side)',
               'data modify storage splendor:ui hand.reserve_count set value 0',
               'execute store result storage splendor:ui hand.reserve_count int 1 run data get storage splendor:ui hand.reserve']
    private += [f'data modify storage splendor:ui hand.t{i} set from storage splendor:ui hand.tokens[{i}]' for i in range(6)]
    private += [f'data modify storage splendor:ui hand.b{i} set from storage splendor:ui hand.bonus[{i}]' for i in range(5)]
    private += ['function splendor:ui/private_show with storage splendor:ui hand']
    put('ui/private', private)
    put('ui/private_show', '$data modify storage splendor:ui private set value ' + js({'text': '', 'extra': [text('你的筹码（$(token_count)／10）：\n', 'gray')] + gems('t') + [text('\n永久折扣：白$(b0) 蓝$(b1) 绿$(b2) 红$(b3) 黑$(b4)\n声望$(vp)分 · 已购$(card_count)张 · 预约$(reserve_count)／3', 'gray')]}))
    put('ui/table_summary', '''
$data modify storage splendor:ui public set value {text:"",extra:[{text:"第$(round)轮 · 当前：",color:"gold"}]}
$data modify storage splendor:ui public.extra append from entity @s data.splendor.p$(turn).name
execute if score @s sp_state matches 2 run data modify storage splendor:ui public.extra append value {text:" · 请退回超限筹码",color:"red"}
execute if score @s sp_state matches 3 run data modify storage splendor:ui public.extra append value {text:" · 请选择一位贵族",color:"yellow"}
execute if data entity @s data.splendor{final_round:1} run data modify storage splendor:ui public.extra append value {text:" · 最后一轮",color:"light_purple"}
''')
    put('ui/open', '''
function splendor:input/context
execute unless entity @s[tag=sp.actor] run return 0
scoreboard players set @s sp_panel 0
function splendor:ui/begin
'''+ '\n'.join([button(2, '查看开发卡', 'aqua'), button(5, '我的预约牌', 'aqua'), button(6, '玩家资产', 'aqua'), button(7, '查看贵族', 'yellow'), button(3, '拿取宝石', 'green', 'if score @s sp_side = @e[tag=sp.current,limit=1] sp_turn if entity @e[tag=sp.current,scores={sp_state=1,sp_anim=0},limit=1]'), button(4, '盲抽预约', 'gold', 'if score @s sp_side = @e[tag=sp.current,limit=1] sp_turn if entity @e[tag=sp.current,scores={sp_state=1,sp_anim=0},limit=1]'), button(20, '退回超限筹码', 'red', 'if score @s sp_side = @e[tag=sp.current,limit=1] sp_turn if entity @e[tag=sp.current,scores={sp_state=2,sp_anim=0},limit=1]'), button(7, '选择来访贵族', 'green', 'if score @s sp_side = @e[tag=sp.current,limit=1] sp_turn if entity @e[tag=sp.current,scores={sp_state=3,sp_anim=0},limit=1]'), button(8, '游戏规则', 'gray'), button(9, '音乐开关', 'gray'), 'function splendor:ui/show with storage splendor:ui']))
    put('ui/market', ['scoreboard players set @s sp_panel 4', 'function splendor:ui/begin', 'data modify storage splendor:ui title set value "璀璨宝石 · 开发卡市场"', 'data modify storage splendor:ui picture set value {text:"\\n\\n\\n\\n\\n\\n",extra:[]}'] +
        [f'function splendor:ui/market_slot {{slot:{slot},code:{100+slot}}}' + ('\ndata modify storage splendor:ui picture.extra append value {text:"\\n\\n\\n\\n\\n\\n\\n\\n"}' if slot in (3,7) else '') for slot in range(12)] +
        ['data modify storage splendor:ui detail set value {text:"点击牌面查看费用、购买或预约；空位表示该级牌堆已用完。",color:"gray"}', button(1, '返回菜单'), 'function splendor:ui/show with storage splendor:ui'])
    put('ui/market_slot', '''
$data modify storage splendor:ui icon_id set from entity @e[tag=sp.current,limit=1] data.splendor.market[$(slot)]
$scoreboard players set #ui_code sp_ctx $(code)
scoreboard players operation #ui_code sp_ctx += #ui_base sp_ctx
execute store result storage splendor:ui code int 1 run scoreboard players get #ui_code sp_ctx
function splendor:ui/market_icon with storage splendor:ui
''')
    put('ui/market_icon', '''
data modify storage splendor:ui image set value {text:"[空位]",color:"gray"}
$execute if predicate {condition:"minecraft:value_check",value:$(icon_id),range:{min:0,max:89}} run function splendor:ui/card_icon {id:$(icon_id)}
$data modify storage splendor:ui image.click_event set value {action:"run_command",command:"trigger sp_action set $(code)"}
data modify storage splendor:ui picture.extra append from storage splendor:ui image
data modify storage splendor:ui picture.extra append value {text:"  "}
''')
    put('ui/card_icon', [f'$execute if predicate {{condition:"minecraft:value_check",value:$(id),range:{i}}} run data modify storage splendor:ui image set value '+js({'text':chr(0xE900+i), 'font':'card:splendor/cards','color':'white'}) for i in range(90)])
    put('ui/reserved', ['scoreboard players set @s sp_panel 5', 'function splendor:ui/begin', 'data modify storage splendor:ui title set value "璀璨宝石 · 我的预约牌"', 'data modify storage splendor:ui picture set value {text:"\\n\\n\\n\\n\\n\\n",extra:[]}'] +
        ['execute unless data storage splendor:ui hand.reserve[0] run data modify storage splendor:ui picture set value {text:"暂无预约牌",color:"gray"}'] + [f'execute if data storage splendor:ui hand.reserve[{i}] run function splendor:ui/reserve_slot {{index:{i},code:{120+i}}}' for i in range(3)] +
        ['data modify storage splendor:ui detail set value {text:"预约牌仅本人可见。最多3张，不能丢弃；购买后释放预约位。",color:"gray"}', button(1, '返回菜单'), 'function splendor:ui/show with storage splendor:ui'])
    put('ui/reserve_slot', '''
$data modify storage splendor:ui icon_id set from storage splendor:ui hand.reserve[$(index)]
$scoreboard players set #ui_code sp_ctx $(code)
scoreboard players operation #ui_code sp_ctx += #ui_base sp_ctx
execute store result storage splendor:ui code int 1 run scoreboard players get #ui_code sp_ctx
function splendor:ui/market_icon with storage splendor:ui
''')
    put('ui/read_target', ['data modify storage splendor:ui icon_id set value -1']+
        [f'execute if score @s sp_target matches {i} run data modify storage splendor:ui icon_id set from entity @e[tag=sp.current,limit=1] data.splendor.market[{i}]' for i in range(12)]+
        [f'execute if score @s sp_target matches {12+i} run data modify storage splendor:ui icon_id set from storage splendor:ui hand.reserve[{i}]' for i in range(3)]+
        ['scoreboard players set #card sp_ctx -1', 'execute store result score #card sp_ctx run data get storage splendor:ui icon_id', 'execute unless score #card sp_ctx matches 0..89 run return 0', 'function splendor:ui/read_card with storage splendor:ui'])
    put('ui/read_card', '$data modify storage splendor:ui card set from storage splendor:cards cards[$(icon_id)]')
    put('ui/details', '''
scoreboard players set @s sp_panel 3
function splendor:ui/begin
function splendor:ui/read_target
execute unless score #card sp_ctx matches 0..89 run return run function splendor:ui/market
function splendor:ui/card_icon {id:0}
function splendor:ui/card_picture with storage splendor:ui
function splendor:ui/autopay
function splendor:ui/editor_show
''')
    put('ui/card_picture', '''
function splendor:ui/card_icon {id:$(icon_id)}
data modify storage splendor:ui picture set value {text:"\\n\\n\\n\\n\\n\\n",extra:[]}
data modify storage splendor:ui picture.extra append from storage splendor:ui image
'''.replace('function splendor:ui/card_icon {id:$(icon_id)}', '$function splendor:ui/card_icon {id:$(icon_id)}'))
    auto = ['scoreboard players set #gold sp_ctx 0']
    for i in range(5):
        auto += [f'execute store result score #cost sp_ctx run data get storage splendor:ui card.cost[{i}]', f'execute store result score #bonus sp_ctx run data get storage splendor:ui hand.bonus[{i}]', 'scoreboard players operation #cost sp_ctx -= #bonus sp_ctx', 'execute if score #cost sp_ctx matches ..-1 run scoreboard players set #cost sp_ctx 0', f'execute store result storage splendor:ui card.d{i} int 1 run scoreboard players get #cost sp_ctx', f'execute store result score #held sp_ctx run data get storage splendor:ui hand.tokens[{i}]', f'scoreboard players operation @s sp_pick{i} = #cost sp_ctx', f'execute if score #cost sp_ctx > #held sp_ctx run scoreboard players operation @s sp_pick{i} = #held sp_ctx', f'scoreboard players operation #cost sp_ctx -= @s sp_pick{i}', 'scoreboard players operation #gold sp_ctx += #cost sp_ctx']
    auto += ['scoreboard players operation @s sp_pick5 = #gold sp_ctx']
    put('ui/autopay', auto)
    put('ui/token_begin', [f'scoreboard players set @s sp_pick{i} 0' for i in range(6)] + ['scoreboard players set @s sp_panel 1', 'function splendor:ui/editor_show'])
    put('ui/return_begin', [f'scoreboard players set @s sp_pick{i} 0' for i in range(6)] + ['scoreboard players set @s sp_panel 2', 'function splendor:ui/editor_show'])
    edit = ['function splendor:ui/begin', 'data modify storage splendor:ui title set value "璀璨宝石 · 选择筹码"', 'data modify storage splendor:ui detail set value {text:"",extra:[]}', 'execute if score @s sp_panel matches 3 run function splendor:ui/read_target', 'execute if score @s sp_panel matches 3 run function splendor:ui/card_picture with storage splendor:ui',
            'execute if score @s sp_panel matches 1 run data modify storage splendor:ui detail.extra append value {text:"拿三颗异色（不足三色时拿剩余颜色），或同色两颗（拿前该堆至少4颗）。黄金只能预约获得。\\n",color:"gray"}',
            'execute if score @s sp_panel matches 2 run data modify storage splendor:ui detail.extra append value {text:"选择退回的筹码，恰好退到10颗；可以退本次刚拿到的筹码或黄金。\\n",color:"yellow"}']
    # 必须保留卡片原价和折扣后实价，编辑黄金时不重新自动改写选择。
    edit += ['execute if score @s sp_panel matches 3 run function splendor:ui/payment_summary']
    for i in range(6):
        edit += [f'execute store result storage splendor:ui pick int 1 run scoreboard players get @s sp_pick{i}', f'function splendor:ui/editor_row {{index:{i},name:"{NAMES[i]}",minus:{200+i*2},plus:{201+i*2}}}']
    edit += [button(10, '确认拿取', 'green', 'if score @s sp_panel matches 1'), button(11, '确认退回', 'green', 'if score @s sp_panel matches 2'), button(12, '确认购买', 'green', 'if score @s sp_panel matches 3'), button(13, '预约此牌', 'gold', 'if score @s sp_panel matches 3 if score @s sp_target matches 0..11'), button(1, '返回菜单'), 'function splendor:ui/show with storage splendor:ui']
    put('ui/editor_show', edit)
    pay_summary=[]
    for i in range(5):
        pay_summary += [f'execute store result score #cost sp_ctx run data get storage splendor:ui card.cost[{i}]', f'execute store result score #bonus sp_ctx run data get storage splendor:ui hand.bonus[{i}]', 'scoreboard players operation #cost sp_ctx -= #bonus sp_ctx', 'execute if score #cost sp_ctx matches ..-1 run scoreboard players set #cost sp_ctx 0', f'execute store result storage splendor:ui card.d{i} int 1 run scoreboard players get #cost sp_ctx', f'data modify storage splendor:ui card.c{i} set from storage splendor:ui card.cost[{i}]']
    pay_summary += ['function splendor:ui/payment_text with storage splendor:ui card']
    put('ui/payment_summary',pay_summary)
    put('ui/payment_text', '$data modify storage splendor:ui detail.extra append value {text:"声望$(points)分 · 第$(tier)级\\n原价：白$(c0) 蓝$(c1) 绿$(c2) 红$(c3) 黑$(c4)\\n折扣后：白$(d0) 蓝$(d1) 绿$(d2) 红$(d3) 黑$(d4)\\n下方选择实际支付。可少付某色、用等量黄金替代，不能超付。\\n",color:"gray"}')
    put('ui/editor_row', '''
$scoreboard players set #ui_code sp_ctx $(minus)
scoreboard players operation #ui_code sp_ctx += #ui_base sp_ctx
execute store result storage splendor:ui minus int 1 run scoreboard players get #ui_code sp_ctx
$scoreboard players set #ui_code sp_ctx $(plus)
scoreboard players operation #ui_code sp_ctx += #ui_base sp_ctx
execute store result storage splendor:ui plus int 1 run scoreboard players get #ui_code sp_ctx
$data modify storage splendor:ui row_name set value "$(name)"
function splendor:ui/row_append with storage splendor:ui
''')
    put('ui/row_append', '$data modify storage splendor:ui detail.extra append value {text:"",extra:[{text:"$(row_name)：",color:"gray"},{text:" [−] ",color:"aqua",click_event:{action:"run_command",command:"trigger sp_action set $(minus)"}},{text:"$(pick)",color:"gold",bold:true},{text:" [+] ",color:"aqua",click_event:{action:"run_command",command:"trigger sp_action set $(plus)"}},{text:"\\n"}]}')
    put('ui/edit', '''
execute unless score @s sp_panel matches 1..3 run return run function splendor:ui/open
scoreboard players operation #index sp_ctx = #code sp_ctx
scoreboard players remove #index sp_ctx 200
scoreboard players set #two sp_ctx 2
scoreboard players operation #delta sp_ctx = #index sp_ctx
scoreboard players operation #delta sp_ctx %= #two sp_ctx
scoreboard players operation #index sp_ctx /= #two sp_ctx
'''+ '\n'.join(f'execute if score #index sp_ctx matches {i} if score #delta sp_ctx matches 0 if score @s sp_pick{i} matches 1.. run scoreboard players remove @s sp_pick{i} 1\nexecute if score #index sp_ctx matches {i} if score #delta sp_ctx matches 1 if score @s sp_pick{i} matches ..9 run scoreboard players add @s sp_pick{i} 1' for i in range(6)) + '\nfunction splendor:ui/editor_show')
    public = ['scoreboard players set @s sp_panel 6', 'function splendor:ui/begin', 'data modify storage splendor:ui title set value "璀璨宝石 · 玩家资产"', 'data modify storage splendor:ui detail set value {text:"",extra:[]}']
    public += [f'execute if data entity @e[tag=sp.current,limit=1] data.splendor.p{i}.name run function splendor:ui/public_player {{side:{i}}}' for i in range(1,5)]
    public += [button(1,'返回菜单'), 'function splendor:ui/show with storage splendor:ui']
    put('ui/public', public)
    public_player = ['$data modify storage splendor:ui person set from entity @e[tag=sp.current,limit=1] data.splendor.p$(side)', 'data modify storage splendor:ui person.reserve_count set value 0', 'execute store result storage splendor:ui person.reserve_count int 1 run data get storage splendor:ui person.reserve']
    public_player += [f'data modify storage splendor:ui person.t{i} set from storage splendor:ui person.tokens[{i}]' for i in range(6)]
    public_player += [f'data modify storage splendor:ui person.b{i} set from storage splendor:ui person.bonus[{i}]' for i in range(5)]
    public_player += ['function splendor:ui/public_append with storage splendor:ui person']
    put('ui/public_player', public_player)
    put('ui/public_append', '$data modify storage splendor:ui detail.extra append value {text:"",extra:[$(name),{text:" · $(vp)分 · $(card_count)张开发卡 · 预约$(reserve_count)张\\n筹码：白$(t0) 蓝$(t1) 绿$(t2) 红$(t3) 黑$(t4) 金$(t5)\\n折扣：白$(b0) 蓝$(b1) 绿$(b2) 红$(b3) 黑$(b4)\\n\\n",color:"gray"}]}')
    put('ui/blind', ['scoreboard players set @s sp_panel 8', 'function splendor:ui/begin', 'data modify storage splendor:ui title set value "璀璨宝石 · 盲抽预约"', 'data modify storage splendor:ui detail set value {text:"选定后预约该级牌堆顶牌，仅本人可见。最多预约3张；库存有黄金时同时领取1枚。",color:"gray"}']+[button(140+i, f'预约第{i+1}级牌堆', 'gold',f'if data entity @e[tag=sp.current,limit=1] data.splendor.deck{i+1}[0]') for i in range(3)]+[button(1,'返回菜单'), 'function splendor:ui/show with storage splendor:ui'])
    noble = ['scoreboard players set @s sp_panel 7', 'function splendor:ui/begin', 'data modify storage splendor:ui title set value "璀璨宝石 · 贵族"', 'data modify storage splendor:ui picture set value {text:"\\n\\n\\n\\n\\n\\n",extra:[]}']
    for i in range(5):
        noble += [f'function splendor:ui/noble_slot {{slot:{i},label:{i+1}}}', button(160+i, f'选择第{i+1}位贵族', 'green', f'if score @s sp_side = @e[tag=sp.current,limit=1] sp_turn if entity @e[tag=sp.current,scores={{sp_state=3}},limit=1] if data entity @e[tag=sp.current,limit=1] data.splendor{{eligible:[{i}]}}')]
    noble += ['data modify storage splendor:ui detail set value {text:"每位贵族3分，只看永久折扣，不消耗筹码。每回合最多来访一位；符合多位时由本人选择。",color:"gray"}', button(1,'返回菜单'), 'function splendor:ui/show with storage splendor:ui']
    put('ui/nobles',noble)
    put('ui/noble_slot', '''
$data modify storage splendor:ui picture.extra append value {text:"$(label) ",color:"gray"}
$data modify storage splendor:ui icon_id set from entity @e[tag=sp.current,limit=1] data.splendor.nobles[$(slot)]
function splendor:ui/noble_icon with storage splendor:ui
''')
    put('ui/noble_icon', ['$execute if predicate {condition:"minecraft:value_check",value:$(icon_id),range:-1} run data modify storage splendor:ui picture.extra append value {text:"[空]  ",color:"dark_gray"}']+[f'$execute if predicate {{condition:"minecraft:value_check",value:$(icon_id),range:{i}}} run data modify storage splendor:ui picture.extra append value '+js({'text':chr(0xEA00+i)+'  ', 'font':'card:splendor/cards','color':'white'}) for i in range(10)])
    put('ui/handle', '''
scoreboard players operation #encoded sp_ctx = @s sp_action
scoreboard players set @s sp_action 0
function splendor:input/context
execute unless entity @s[tag=sp.actor] run return 0
execute unless score #encoded sp_ctx matches 20000..999990999 run return 0
scoreboard players operation #nonce sp_ctx = #encoded sp_ctx
scoreboard players operation #nonce sp_ctx /= #factor sp_ctx
execute unless score #nonce sp_ctx = @s sp_nonce run return 0
scoreboard players reset @s sp_nonce
execute unless score @s sp_ui_load = #ui_load sp_ctx run return run function splendor:ui/stale
execute unless score @s sp_ui_table = @s sp_table run return run function splendor:ui/stale
execute unless score @s sp_seen = @e[tag=sp.current,limit=1] sp_epoch run return run function splendor:ui/stale
scoreboard players operation #code sp_ctx = #encoded sp_ctx
scoreboard players operation #code sp_ctx %= #factor sp_ctx
execute if score #code sp_ctx matches 0 run return run dialog clear @s
function splendor:ui/dispatch
''')
    dispatch = [f'execute if score #code sp_ctx matches {code} run return run function splendor:ui/{endpoint}' for code,endpoint in [(1,'open'),(2,'market'),(3,'token_begin'),(4,'blind'),(5,'reserved'),(6,'public'),(7,'nobles'),(8,'rules'),(9,'music'),(20,'return_begin')]]
    dispatch += ['execute if entity @e[tag=sp.current,scores={sp_anim=1..},limit=1] run return run function splendor:ui/open',
                 'execute unless score @s sp_side = @e[tag=sp.current,limit=1] sp_turn run return run function splendor:ui/open',
                 'execute if score #code sp_ctx matches 200..211 run return run function splendor:ui/edit']
    for slot in range(12):
        # 详情查看不限制回合，购买提交仍由引擎校验；放到turn guard之前。
        dispatch.insert(9, f'execute if score #code sp_ctx matches {100+slot} run scoreboard players set @s sp_target {slot}')
    for index in range(3):
        dispatch.insert(9, f'execute if score #code sp_ctx matches {120+index} run scoreboard players set @s sp_target {12+index}')
    guard_index=next(i for i,line in enumerate(dispatch) if 'sp_anim=1..' in line)
    dispatch.insert(guard_index, 'execute if score #code sp_ctx matches 100..122 run return run function splendor:ui/details')
    dispatch += ['execute if score #code sp_ctx matches 10 if score @s sp_panel matches 1 run return run function splendor:ui/submit_take', 'execute if score #code sp_ctx matches 11 if score @s sp_panel matches 2 run return run function splendor:ui/submit_return', 'execute if score #code sp_ctx matches 12 if score @s sp_panel matches 3 run return run function splendor:ui/submit_buy', 'execute if score #code sp_ctx matches 13 if score @s sp_panel matches 3 if score @s sp_target matches 0..11 run return run function splendor:ui/submit_reserve']
    dispatch += [f'execute if score #code sp_ctx matches {140+i} run scoreboard players set @s sp_target {12+i}\nexecute if score #code sp_ctx matches {140+i} run return run function splendor:ui/submit_reserve' for i in range(3)]
    dispatch += [f'execute if score #code sp_ctx matches {160+i} run scoreboard players set @s sp_target {i}\nexecute if score #code sp_ctx matches {160+i} run return run function splendor:ui/submit_noble' for i in range(5)]
    dispatch += ['function splendor:ui/open']
    put('ui/dispatch',dispatch)
    put('ui/stale', ['tellraw @s {text:"[璀璨宝石] 局面或窗口已更新，请重新操作。",color:"gray"}', 'function splendor:ui/open'])
    for endpoint, code, field in [('take',1,'take'),('reserve',2,None),('buy',3,'pay'),('return',4,'take'),('noble',5,None)]:
        body = [f'data modify storage splendor:action input set value {{actor:0,code:{code},target:0,epoch:0,take:[0,0,0,0,0,0],pay:[0,0,0,0,0,0]}}', 'execute store result storage splendor:action input.actor int 1 run scoreboard players get @s sp_side', 'execute store result storage splendor:action input.target int 1 run scoreboard players get @s sp_target', 'execute store result storage splendor:action input.epoch int 1 run scoreboard players get @s sp_seen']
        if field:
            body += [f'execute store result storage splendor:action input.{field}[{i}] int 1 run scoreboard players get @s sp_pick{i}' for i in range(6)]
        body += ['execute as @e[tag=sp.current,limit=1] at @s run function splendor:game/action']
        put('ui/submit_'+endpoint,body)
    put('ui/rules', ['tag @a[tag=ct.rules_actor] remove ct.rules_actor', 'tag @s add ct.rules_actor', 'execute as @e[tag=sp.current,limit=1] at @s run function splendor:rules/show', 'tag @s remove ct.rules_actor'])
    put('ui/music', ['execute as @e[tag=sp.current,limit=1] at @s run function splendor:ui/toggle_music', 'function splendor:ui/open'])
    put('ui/toggle_music', ['scoreboard players add @s sp_music 1', 'execute if score @s sp_music matches 2.. run scoreboard players set @s sp_music 0', 'function splendor:sound/stop', 'execute if score @s sp_music matches 1 run function splendor:sound/start'])
    print('璀璨宝石公共市场与私有预约界面已生成。')


if __name__ == '__main__':
    main()
