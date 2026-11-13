# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set #owner ma_ctx 0
execute on origin if entity @s[tag=ma.dropper] run scoreboard players set #owner ma_ctx 1
execute unless score #owner ma_ctx matches 1 run return 0
data modify storage magical_athlete:input drop set from entity @s Item.components."minecraft:custom_data".magical_athlete
execute if data storage magical_athlete:input drop{choice:1b} as @a[tag=ma.dropper,limit=1] run function magical_athlete:direct/use_choice with storage magical_athlete:input drop
execute unless data storage magical_athlete:input drop{choice:1b} unless data storage magical_athlete:input drop{roster:1b} run function magical_athlete:input/use_drop with storage magical_athlete:input drop
execute if data storage magical_athlete:input drop{roster:1b} as @a[tag=ma.dropper,limit=1] run function magical_athlete:direct/roster_use with storage magical_athlete:input drop
kill @s
# direct-v2
execute as @a[tag=ma.dropper,limit=1] run scoreboard players set @s ma_depoch -1
execute as @a[tag=ma.dropper,limit=1] run function magical_athlete:direct/sync
