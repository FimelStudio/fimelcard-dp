function doudizhu:player/audience
scoreboard players set @e[tag=dd.actors] dd_team 2
function doudizhu:team/assign_fixed
execute as @e[tag=dd.actors,scores={dd_team=1}] run tellraw @a[tag=dd.audience] [{text:"橙队 ",color:"gold",bold:true},{selector:"@s",color:"gold"}]
execute as @e[tag=dd.actors,scores={dd_team=2}] run tellraw @a[tag=dd.audience] [{text:"青队 ",color:"aqua",bold:true},{selector:"@s",color:"aqua"}]
