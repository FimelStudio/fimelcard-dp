# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #value sk_ctx = #base sk_ctx
$execute store result storage skull:ui button.value int 1 run scoreboard players add #value sk_ctx $(choice)
$data modify storage skull:ui button.label set value "$(label)"
function skull:ui/append_button with storage skull:ui button
