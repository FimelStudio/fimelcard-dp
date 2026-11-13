function avalon:context
scoreboard players set @s av_state 1
effect clear @a[tag=av.audience,scores={av_selected=1}] minecraft:glowing
scoreboard players set @a[tag=av.audience] av_selected 0
scoreboard players set @a[tag=av.audience] av_vote 0
scoreboard players set @a[tag=av.audience] av_mission 0
function avalon:map/requirements
execute store result storage avalon:map round int 1 run scoreboard players get @s av_round
function avalon:map/current_need with storage avalon:map
function avalon:game/refresh
