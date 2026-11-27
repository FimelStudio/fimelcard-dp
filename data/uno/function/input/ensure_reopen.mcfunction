# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless entity @s[tag=un.player,tag=ct.player] run return 0
execute unless score @s un_table = @s ct_id run return 0
scoreboard players operation #reopen_table un_ctx = @s un_table
scoreboard players set #reopen_active un_ctx 0
execute as @e[type=minecraft:marker,tag=ct.controller,tag=un.controller,scores={ct_game=11,ct_state=1,un_state=1..5}] if score @s ct_id = #reopen_table un_ctx run scoreboard players set #reopen_active un_ctx 1
execute unless score #reopen_active un_ctx matches 1 run return 0
execute store result storage uno:reopen table int 1 run scoreboard players get @s un_table
function uno:input/place_reopen with storage uno:reopen
