execute if score @s ma_anim matches 1.. run return 0
execute if score @s ct_paused matches 1 run return 0
execute if score @s ma_state matches 1 as @e[tag=ma.pool] if score @s ct_id = #table ma_ctx at @s run particle minecraft:end_rod ~ ~0.33 ~ 0.03 0.01 0.03 0 1 normal @a[tag=ma.audience]
execute if score @s ma_state matches 3 if data entity @s data.magical_athlete.pending{kind:"ready"} as @e[tag=ma.die] if score @s ct_id = #table ma_ctx at @s run particle minecraft:end_rod ~ ~0.22 ~ 0.04 0.01 0.04 0 1 normal @a[tag=ma.audience]
execute if data entity @s data.magical_athlete.pending.options[0] run function magical_athlete:feedback/targets with entity @s data.magical_athlete.pending
