tag @s add dd.controller
scoreboard players operation @s ct_id = @e[type=minecraft:marker,tag=ct.controller,tag=dd.controller,scores={dd_lane=1},distance=..0.1,limit=1] ct_id
scoreboard players operation @s ct_capacity = @e[type=minecraft:marker,tag=ct.controller,tag=dd.controller,scores={dd_lane=1},distance=..0.1,limit=1] ct_capacity
scoreboard players operation @s dd_limit = @e[type=minecraft:marker,tag=ct.controller,tag=dd.controller,scores={dd_lane=1},distance=..0.1,limit=1] dd_limit
scoreboard players operation @s dd_turn_limit = @e[type=minecraft:marker,tag=ct.controller,tag=dd.controller,scores={dd_lane=1},distance=..0.1,limit=1] dd_turn_limit
scoreboard players operation @s dd_audio = @e[type=minecraft:marker,tag=ct.controller,tag=dd.controller,scores={dd_lane=1},distance=..0.1,limit=1] dd_audio
scoreboard players operation @s dd_counts = @e[type=minecraft:marker,tag=ct.controller,tag=dd.controller,scores={dd_lane=1},distance=..0.1,limit=1] dd_counts
scoreboard players operation @s dd_counter = @e[type=minecraft:marker,tag=ct.controller,tag=dd.controller,scores={dd_lane=1},distance=..0.1,limit=1] dd_counter
scoreboard players operation @s dd_noshuffle = @e[type=minecraft:marker,tag=ct.controller,tag=dd.controller,scores={dd_lane=1},distance=..0.1,limit=1] dd_noshuffle
scoreboard players operation @s dd_hide_score = @e[type=minecraft:marker,tag=ct.controller,tag=dd.controller,scores={dd_lane=1},distance=..0.1,limit=1] dd_hide_score
scoreboard players operation @s dd_scoring = @e[type=minecraft:marker,tag=ct.controller,tag=dd.controller,scores={dd_lane=1},distance=..0.1,limit=1] dd_scoring
scoreboard players operation @s dd_id = @s ct_id
scoreboard players set #minus_one dd_ctx -1
scoreboard players operation @s dd_id *= #minus_one dd_ctx
scoreboard players set @s dd_lane 2
scoreboard players set @s dd_humans 4
scoreboard players set @s dd_bidmode 0
scoreboard players set @s dd_round 1
scoreboard players set @s dd_bidbye 6
