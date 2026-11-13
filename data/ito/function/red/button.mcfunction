# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #button it_ctx = #base it_ctx
scoreboard players operation #button it_ctx += @s it_seat
scoreboard players add #button it_ctx 30
execute store result storage ito:ui action int 1 run scoreboard players get #button it_ctx
function ito:ui/button_value with storage ito:ui
data modify storage ito:ui button.label set value {text:"搭档：",extra:[{selector:"@s"}]}
execute if score @s it_offer = #self it_ctx run data modify storage ito:ui button.label.extra append value {text:"（已邀请你）",color:"green"}
function ito:name/resolve
data modify storage ito:ui button.label.extra[0] set from storage ito:name resolved
data modify storage ito:ui dialog.actions append from storage ito:ui button
