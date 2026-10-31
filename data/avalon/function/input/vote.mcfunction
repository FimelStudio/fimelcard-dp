scoreboard players operation #value av_ctx = #action av_ctx
scoreboard players remove #value av_ctx 19
scoreboard players operation @a[tag=av.actor,limit=1] av_vote = #value av_ctx
clear @a[tag=av.actor,limit=1] *[minecraft:custom_data~{avalon:{ballot:1b}}]
tellraw @a[tag=av.actor,limit=1] {text:"表决已提交，请等待其他玩家。",color:"green"}
scoreboard players set #done av_ctx 0
execute as @a[tag=av.audience,scores={av_vote=1..2}] run scoreboard players add #done av_ctx 1
execute if score #done av_ctx = @s av_players run function avalon:game/vote_result
