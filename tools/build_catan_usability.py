"""卡坦岛直接操作的即时校验、明确失败原因及单次 Q 提交。"""
from build_catan_game import PACK,put
from build_catan_direct import notice,RES

ROOT=PACK/'data/catan/function'


def replace(name,old,new):
    path=ROOT/(name+'.mcfunction')
    body=path.read_text(encoding='utf-8')
    assert old in body,(name,old)
    put(name,body.replace(old,new))


def build():
    put('direct/turn_guard',[
        'scoreboard players set #direct_ready ca_ctx 0',
        'execute if score @s ct_paused matches 1 run return run function catan:direct/paused_note',
        'execute if entity @e[tag=ca.current,scores={ct_paused=1},limit=1] run return run function catan:direct/paused_note',
        'execute unless score @s ca_side = @e[tag=ca.current,limit=1] ca_turn run return run function catan:direct/wait',
        'execute if entity @e[tag=ca.current,scores={ca_state=11},limit=1] run return run function catan:direct/finished_note',
        'execute if entity @e[tag=ca.current,scores={ca_anim=1..},limit=1] run return run function catan:direct/busy',
        'execute if entity @e[tag=ca.current,scores={ca_vtimer=1..},limit=1] run return run function catan:direct/busy',
        'execute if entity @e[tag=ca.current,scores={ca_state=10},limit=1] run return run function catan:direct/busy',
        'scoreboard players set #direct_ready ca_ctx 1'])
    put('direct/main_guard',[
        'function catan:direct/turn_guard',
        'execute unless score #direct_ready ca_ctx matches 1 run return 0',
        'execute if entity @e[tag=ca.current,scores={ca_state=4},limit=1] run return 1',
        'scoreboard players set #direct_ready ca_ctx 0',
        'function catan:direct/phase_note'])
    put('direct/phase_note',[
        'execute if entity @e[tag=ca.current,scores={ca_state=3},limit=1] run return run function catan:direct/roll_first',
        notice('当前阶段不能建造或交易：请先完成初始布置、弃牌或强盗操作。','red')])
    put('direct/roll_first',notice('请先投骰，完成资源分配后才能建造或与银行兑换。','red'))
    put('direct/paused_note',notice('牌桌已暂停，恢复后才能操作。','red'))
    put('direct/finished_note',notice('本局已经结束，不能再执行操作。','red'))
    # 开启资源选择前检查，失败时保持原编辑状态。
    replace('direct/bank_begin','scoreboard players set @s ca_edit 3',
        'function catan:direct/main_guard\nexecute unless score #direct_ready ca_ctx matches 1 run return 0\nscoreboard players set @s ca_edit 3')
    replace('direct/resource','execute if score @s ca_step matches 0 run return run function catan:direct/pay_select',
        'execute unless score @s ca_edit matches 3 run return 0\nfunction catan:direct/main_guard\nexecute unless score #direct_ready ca_ctx matches 1 run return 0\nexecute if score @s ca_step matches 0 run return run function catan:direct/pay_select')
    # 发展卡选择资源的入口也先验证当前回合、阶段、旧牌和本回合次数。
    replace('direct/dev_use','function catan:direct/confirm','function catan:direct/dev_guard\nexecute unless score #direct_ready ca_ctx matches 1 run return 0\nfunction catan:direct/submit')
    put('direct/dev_guard',[
        'function catan:direct/turn_guard',
        'execute unless score #direct_ready ca_ctx matches 1 run return 0',
        'execute unless entity @e[tag=ca.current,scores={ca_state=3..4},limit=1] run function catan:direct/dev_phase',
        'execute unless score #direct_ready ca_ctx matches 1 run return 0',
        'execute if data entity @e[tag=ca.current,limit=1] data.catan{used_dev:1} run function catan:direct/dev_limit'])
    put('direct/dev_phase','scoreboard players set #direct_ready ca_ctx 0\n'+notice('发展卡只能在本人投骰前或自由行动阶段使用。','red'))
    put('direct/dev_limit','scoreboard players set #direct_ready ca_ctx 0\n'+notice('本回合已经使用过一张发展卡，不能再使用。','red'))
    replace('direct/confirm','execute if score @s ca_confirm = #code ca_ctx',
        'execute if score #code ca_ctx matches 352..354 run return run function catan:direct/submit\nexecute if score #code ca_ctx matches 401..404 run return run function catan:direct/submit\nexecute if score #code ca_ctx matches 23 run function catan:direct/buy_check\nexecute if score #code ca_ctx matches 29 run function catan:direct/main_guard\nexecute if score #code ca_ctx matches 23 unless score #direct_ready ca_ctx matches 1 run return 0\nexecute if score #code ca_ctx matches 29 unless score #direct_ready ca_ctx matches 1 run return 0\nexecute if score @s ca_confirm = #code ca_ctx')
    replace('direct/confirm','execute if score @s ca_confirm = #code ca_ctx',
        'execute if score #code ca_ctx matches 23 run return run function catan:direct/submit\nexecute if score #code ca_ctx matches 29 run return run function catan:direct/submit\nexecute if score @s ca_confirm = #code ca_ctx')
    for name in ('direct/controls','direct/resource_controls','direct/selected_resource','direct/plenty_select','direct/bank_begin','direct/bank_note'):
        path=ROOT/(name+'.mcfunction');body=path.read_text(encoding='utf-8')
        body=body.replace('确认兑换〔Q两次〕','确认兑换〔Q〕').replace('确认垄断〔Q两次〕','确认垄断〔Q〕').replace('确认丰收〔Q两次〕','确认丰收〔Q〕')
        body=body.replace('按Q两次提交','按Q一次提交').replace('确认兑换按Q两次','确认兑换按Q一次')
        put(name,body)
    replace('direct/dev_item','Q选中，再按Q使用','Q一次使用／选择资源')
    # 第一次 Q 或右键即检查费用；合法落点仍先预览再确认。
    replace('input/aim','function catan:input/ray',
        'function catan:direct/build_check\nexecute unless score #direct_ready ca_ctx matches 1 run return 0\nfunction catan:input/ray')
    put('direct/build_check',[
        'function catan:direct/turn_guard',
        'execute unless score #direct_ready ca_ctx matches 1 run return 0',
        'execute if entity @e[tag=ca.current,scores={ca_state=1..2},limit=1] run return 1',
        'execute if entity @e[tag=ca.current,scores={ca_state=6},limit=1] run return 1',
        'execute if entity @e[tag=ca.current,scores={ca_state=8},limit=1] run return 1',
        'function catan:direct/main_guard',
        'execute unless score #direct_ready ca_ctx matches 1 run return 0',
        'execute if score @s ca_mode matches 2 run function catan:direct/cost {label:"建造村庄",cost:[1,1,1,1,0]}',
        'execute if score @s ca_mode matches 3 run function catan:direct/cost {label:"修建道路",cost:[1,1,0,0,0]}',
        'execute if score @s ca_mode matches 4 run function catan:direct/cost {label:"升级城市",cost:[0,0,0,2,3]}',
        'execute if score #direct_ready ca_ctx matches 1 run function catan:direct/build_stock'])
    put('direct/build_stock',[
        'scoreboard players set #pieces ca_ctx 0',
        'execute if score @s ca_mode matches 2 store result score #pieces ca_ctx run data get storage catan:ui hand.settlements_left',
        'execute if score @s ca_mode matches 3 store result score #pieces ca_ctx run data get storage catan:ui hand.roads_left',
        'execute if score @s ca_mode matches 4 store result score #pieces ca_ctx run data get storage catan:ui hand.cities_left',
        'execute unless score #pieces ca_ctx matches 1.. run scoreboard players set #direct_ready ca_ctx 0',
        'execute unless score #direct_ready ca_ctx matches 1 run '+notice('该类建筑棋子已经用完，无法继续建造。','red')])
    put('direct/buy_check',[
        'function catan:direct/main_guard',
        'execute unless score #direct_ready ca_ctx matches 1 run return 0',
        'execute unless data entity @e[tag=ca.current,limit=1] data.catan.dev_deck[0] run return run function catan:direct/deck_empty',
        'function catan:direct/cost {label:"购买发展卡",cost:[0,0,1,1,1]}'])
    put('direct/deck_empty','scoreboard players set #direct_ready ca_ctx 0\n'+notice('发展卡牌堆已空，无法购买。','red'))
    cost=['function catan:direct/private',
        '$data modify storage catan:direct cost set value $(cost)',
        '$data modify storage catan:direct failure set value {text:{text:"$(label)材料不足：",color:"red",extra:[]}}']
    for i,(name,_,_) in enumerate(RES):
        cost += [f'execute store result score #cost_have ca_ctx run data get storage catan:ui hand.resources[{i}]',
                 f'execute store result score #cost_need ca_ctx run data get storage catan:direct cost[{i}]',
                 'execute if score #cost_have ca_ctx < #cost_need ca_ctx run scoreboard players set #direct_ready ca_ctx 0',
                 'execute store result storage catan:direct shortage.have int 1 run scoreboard players get #cost_have ca_ctx',
                 'scoreboard players operation #cost_need ca_ctx -= #cost_have ca_ctx',
                 'execute store result storage catan:direct shortage.need int 1 run scoreboard players get #cost_need ca_ctx',
                 f'data modify storage catan:direct shortage.name set value "{name}"',
                 'execute if score #cost_need ca_ctx matches 1.. run function catan:direct/cost_line with storage catan:direct shortage']
    cost += ['execute unless score #direct_ready ca_ctx matches 1 run function catan:hud/notice with storage catan:direct failure']
    put('direct/cost',cost)
    put('direct/cost_line','$data modify storage catan:direct failure.text.extra append value {text:"缺$(name)$(need)（现有$(have)） ",color:"red"}')
    # 银行在选择支付种类时立即显示实际港口比例和缺额。
    put('direct/pay_select',[
        'scoreboard players operation @s ca_pay = #resource ca_ctx',
        'scoreboard players set @s ca_receive -1',
        'function catan:direct/bank_read',
        'function catan:direct/bank_payment with storage catan:direct',
        'execute unless score #direct_ready ca_ctx matches 1 run return 0',
        'scoreboard players set @s ca_step 1',
        'function catan:direct/pay_note with storage catan:direct'])
    put('direct/bank_read',[
        'function catan:direct/private',
        'data modify storage catan:ui bank set from entity @e[tag=ca.current,limit=1] data.catan.bank',
        'function catan:ui/bank_summary',
        'execute store result storage catan:direct pay int 1 run scoreboard players get @s ca_pay',
        'execute store result storage catan:direct receive int 1 run scoreboard players get @s ca_receive',
        *[f'execute if score @s ca_pay matches {i} run data modify storage catan:direct give_name set value "{name}"' for i,(name,_,_) in enumerate(RES)],
        *[f'execute if score @s ca_receive matches {i} run data modify storage catan:direct get_name set value "{name}"' for i,(name,_,_) in enumerate(RES)]])
    put('direct/bank_payment',[
        '$data modify storage catan:direct ratio set from storage catan:ui ratio$(pay)',
        '$data modify storage catan:direct have set from storage catan:ui hand.resources[$(pay)]',
        'execute store result score #bank_have ca_ctx run data get storage catan:direct have',
        'execute store result score #bank_ratio ca_ctx run data get storage catan:direct ratio',
        'execute if score #bank_have ca_ctx < #bank_ratio ca_ctx run scoreboard players set #direct_ready ca_ctx 0',
        'execute unless score #direct_ready ca_ctx matches 1 run function catan:direct/bank_short with storage catan:direct'])
    put('direct/bank_short','$function catan:hud/notice {text:{text:"$(give_name)不足：按当前港口比例需$(ratio)张换1张，你只有$(have)张。",color:"red"}}')
    put('direct/pay_note','$function catan:hud/notice {text:{text:"支付$(give_name)$(ratio)张（持有$(have)）；再对要换取的资源按Q。",color:"aqua"}}')
    put('direct/bank_validate',[
        'function catan:direct/main_guard',
        'execute unless score #direct_ready ca_ctx matches 1 run return 0',
        'function catan:direct/bank_read',
        'function catan:direct/bank_payment with storage catan:direct',
        'execute unless score #direct_ready ca_ctx matches 1 run return 0',
        'execute if score @s ca_pay = @s ca_receive run return run function catan:direct/bank_same',
        'function catan:direct/bank_stock with storage catan:direct'])
    put('direct/bank_same','scoreboard players set #direct_ready ca_ctx 0\nscoreboard players set @s ca_step 1\n'+notice('银行兑换必须选择不同资源，不能用同种资源兑换自身。','red'))
    put('direct/bank_stock',[
        '$execute store result score #bank_stock ca_ctx run data get storage catan:ui bank[$(receive)]',
        'execute unless score #bank_stock ca_ctx matches 1.. run scoreboard players set #direct_ready ca_ctx 0',
        'execute unless score #direct_ready ca_ctx matches 1 run function catan:direct/bank_empty with storage catan:direct'])
    put('direct/bank_empty',['scoreboard players set @s ca_step 1','$function catan:hud/notice {text:{text:"银行的$(get_name)已用完，请改选其他资源。",color:"red"}}'])
    put('direct/bank_quote',[
        'function catan:direct/bank_validate',
        'execute if score #direct_ready ca_ctx matches 1 run function catan:direct/bank_note with storage catan:direct'])
    replace('direct/submit','execute if score #code ca_ctx matches 352 run return run function catan:ui/send_bank',
        'execute if score #code ca_ctx matches 352 run return run function catan:direct/bank_commit')
    put('direct/bank_commit',[
        'function catan:direct/bank_validate',
        'execute unless score #direct_ready ca_ctx matches 1 run return 0',
        'function catan:ui/send_bank'])
    # 资源专用操作期间给出持续的下一步，避免等待提示覆盖选择状态。
    put('hud/selection_status',[
        'execute if score @s ca_edit matches 3 if score @s ca_step matches 0 run data modify storage fimel_title:io text.text set value "银行兑换：资源按Q选择支付，再选换取种类；确认兑换按Q一次"',
        'execute if score @s ca_edit matches 3 if score @s ca_step matches 1 run data modify storage fimel_title:io text.text set value "已选支付资源：对要换取的资源按Q，然后确认兑换按Q一次"',
        'execute if score @s ca_edit matches 4 run data modify storage fimel_title:io text.text set value "垄断：资源按Q选择种类，确认垄断按Q一次"',
        'execute if score @s ca_edit matches 5 run data modify storage fimel_title:io text.text set value "丰收：资源按Q选择两张，确认丰收按Q一次"'])
    replace('hud/status','function catan:hud/center','function catan:hud/selection_status\nfunction catan:hud/center')


if __name__=='__main__':build()
