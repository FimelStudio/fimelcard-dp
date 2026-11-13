# uninstall-guard: begin (tools/build_uninstall.py)
execute if data storage cardtable:uninstall active run return 0
execute unless score #version ct_ctx matches 1.. run return 0
# uninstall-guard: end
# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function weiqi:input/tick
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=20},tag=!go.controller] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function weiqi:game/init_table
execute as @e[type=minecraft:marker,tag=go.controller,scores={ct_game=20}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function weiqi:system/tick
