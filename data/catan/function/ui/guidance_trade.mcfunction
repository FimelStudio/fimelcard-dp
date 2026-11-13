# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$execute if score @s ca_side matches $(to) if entity @e[tag=ca.current,scores={ca_state=4},limit=1] run data modify storage catan:ui guidance set value {text:"你收到交易报价：第9格 Q → 查看交易请求，检查价格后同意／拒绝。",color:"aqua"}
$execute if score @s ca_side matches $(to) if entity @e[tag=ca.current,scores={ca_state=4},limit=1] run data modify storage catan:ui hud_guidance set value {text:"收到报价 · 第9格 Q 查看交易请求",color:"aqua"}
