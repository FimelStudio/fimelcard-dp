scoreboard players set #yes av_ctx 0
execute as @a[tag=av.audience,scores={av_vote=1}] run scoreboard players add #yes av_ctx 1
execute as @a[tag=av.audience,scores={av_vote=1}] run tellraw @a[tag=av.audience] [{selector:"@s",color:"white"},{text:"：同意",color:"green"}]
execute as @a[tag=av.audience,scores={av_vote=2}] run tellraw @a[tag=av.audience] [{selector:"@s",color:"white"},{text:"：反对",color:"red"}]
scoreboard players operation #double av_ctx = #yes av_ctx
scoreboard players operation #double av_ctx += #yes av_ctx
execute if score #double av_ctx > @s av_players run return run function avalon:game/mission_start
scoreboard players add @s av_reject 1
tellraw @a[tag=av.audience] {text:"组队被否决，换下一位队长；任务轮次不变。",color:"yellow"}
function avalon:game/next_leader
function avalon:game/team
