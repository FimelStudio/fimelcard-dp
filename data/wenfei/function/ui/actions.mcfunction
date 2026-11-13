# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
data modify storage wenfei:ui dialog.type set value "minecraft:multi_action"
data modify storage wenfei:ui dialog.actions set value []
data modify storage wenfei:ui dialog.columns set value 2
data modify storage wenfei:ui dialog.exit_action set value {label:{text:"关闭（按Q可重开）"}}
