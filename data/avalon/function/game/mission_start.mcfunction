tellraw @a[tag=av.audience] [{text:"出征队伍通过：",color:"gold"},{selector:"@a[tag=av.audience,scores={av_selected=1}]"}]
scoreboard players set @s av_reject 0
scoreboard players set @s av_state 3
scoreboard players set @a[tag=av.audience] av_mission 0
function avalon:game/refresh
