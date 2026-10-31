execute if score #action av_ctx matches 31 unless score @a[tag=av.actor,limit=1] av_role matches 4..7 run return 0
scoreboard players operation #value av_ctx = #action av_ctx
scoreboard players remove #value av_ctx 29
scoreboard players operation @a[tag=av.actor,limit=1] av_mission = #value av_ctx
scoreboard players set #done av_ctx 0
execute as @a[tag=av.audience,scores={av_selected=1,av_mission=1..2}] run scoreboard players add #done av_ctx 1
execute if score #done av_ctx = @s av_need run function avalon:game/mission_result
