# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage skull:ui dialog.body append value {type:"minecraft:plain_message",contents:{text:"当前叫号：$(current)；桌上共$(total)张。点击数字叫号，必须高于当前叫号、不小于自己扣牌数；开始竞标后不能加牌。",color:"yellow"}}
