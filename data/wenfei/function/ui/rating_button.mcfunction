# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage wenfei:ui button.label set value "$(points) 分"
scoreboard players operation #value wq_ctx = #base wq_ctx
$execute store result storage wenfei:ui button.value int 1 run scoreboard players add #value wq_ctx $(choice)
function wenfei:ui/button with storage wenfei:ui button
