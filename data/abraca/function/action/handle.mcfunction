scoreboard players operation #ctx ab_ctx = @s ab_id
tag @s add ab.actor
execute if score @s ab_action matches 1 run tellraw @s [{text:'[出包魔法师] ',color:'dark_purple'},{text:'正在判定古代巨龙……',color:'yellow'}]
execute if score @s ab_action matches 9 run execute as @e[type=minecraft:marker,tag=ab.controller] if score @s ab_id = #ctx ab_ctx run function abraca:turn/end
execute if score @s ab_action matches 9 run tag @s remove ab.actor
execute if score @s ab_action matches 9 run scoreboard players set @s ab_action 0
execute if score @s ab_action matches 9 run return 0
execute as @e[type=minecraft:marker,tag=ab.controller] if score @s ab_id = #ctx ab_ctx run function abraca:action/resolve
tag @s remove ab.actor
scoreboard players set @s ab_action 0
