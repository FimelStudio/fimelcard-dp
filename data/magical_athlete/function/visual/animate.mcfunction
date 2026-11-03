function magical_athlete:visual/context
data modify entity @s data.magical_athlete.visual_queue set from entity @s data.magical_athlete.events
scoreboard players set @s ma_anim 0
execute unless data entity @s data.magical_athlete.visual_queue[0] run return 0
scoreboard players set @s ma_anim 1
scoreboard players set @s ma_vtimer 0
