# uninstall-guard: begin (tools/build_uninstall.py)
execute if data storage cardtable:uninstall active run return 0
execute unless score #version ct_ctx matches 1.. run return 0
# uninstall-guard: end
# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function love_letter:input/tick
execute as @e[type=minecraft:marker,tag=ll.controller,scores={ct_game=17}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function love_letter:visual/tick
execute as @e[type=minecraft:marker,tag=ll.controller,scores={ct_game=17,ll_state=1..4}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function love_letter:game/tick
