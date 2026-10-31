execute unless score @s av_state matches 1..3 run return 0
scoreboard players set @s av_state 4
scoreboard players set @a[tag=av.audience] av_target 0
tellraw @a[tag=av.audience] [{text:"刺客翻牌：",color:"red"},{selector:"@a[tag=av.audience,scores={av_role=5}]"},{text:"。其他操作已停止，讨论后由刺客选择目标。"}]
function avalon:game/refresh
