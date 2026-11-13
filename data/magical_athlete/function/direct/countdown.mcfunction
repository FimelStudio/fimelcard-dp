execute unless score @s ma_state matches 4 run return run scoreboard players set @s ma_next 0
execute unless score @s ma_next matches 1.. run scoreboard players set @s ma_next 120
scoreboard players remove @s ma_next 1
execute unless score @s ma_next matches 0 run return 0
execute as @a[tag=ma.audience,limit=1] run function magical_athlete:direct/next_race
