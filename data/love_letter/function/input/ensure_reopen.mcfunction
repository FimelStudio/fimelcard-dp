# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless entity @s[tag=ll.player,tag=ct.player] run return 0
execute unless score @s ll_table = @s ct_id run return 0
scoreboard players operation #reopen_table ll_ctx = @s ll_table
scoreboard players set #reopen_active ll_ctx 0
execute as @e[type=minecraft:marker,tag=ct.controller,tag=ll.controller,scores={ct_game=17,ct_state=1,ll_state=1..4}] if score @s ct_id = #reopen_table ll_ctx run scoreboard players set #reopen_active ll_ctx 1
execute unless score #reopen_active ll_ctx matches 1 run return 0
execute store result storage love_letter:reopen table int 1 run scoreboard players get @s ll_table
function love_letter:input/place_reopen with storage love_letter:reopen
