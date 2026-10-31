execute unless score @s av_state matches 1 run return 0
scoreboard players set #selected av_ctx 0
execute as @a[tag=av.audience,scores={av_selected=1}] run scoreboard players add #selected av_ctx 1
execute unless score #selected av_ctx = @s av_need run return run tellraw @a[tag=av.actor,limit=1] {text:"请选择规定数量的出征队员。",color:"yellow"}
scoreboard players operation #force av_ctx = @s av_players
scoreboard players remove #force av_ctx 1
execute if score @s av_reject >= #force av_ctx run return run function avalon:game/mission_start
scoreboard players set @s av_state 2
scoreboard players set @a[tag=av.audience] av_vote 0
function avalon:game/refresh
