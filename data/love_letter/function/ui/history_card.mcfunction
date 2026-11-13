# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$execute unless data entity @s data.discards[$(index)] run return 0
$execute store result score #ui_card ll_ctx run data get entity @s data.discards[$(index)]
function love_letter:ui/role
data modify storage love_letter:ui rows.extra append from storage love_letter:ui role
data modify storage love_letter:ui rows.extra append value {text:"  "}
