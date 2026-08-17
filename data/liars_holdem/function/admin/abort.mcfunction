tag @s add lh.admin
tag @e[tag=lh.admin_controller] remove lh.admin_controller
execute as @e[type=minecraft:marker,tag=lh.controller,distance=..8,sort=nearest,limit=1] run tag @s add lh.admin_controller
execute unless entity @e[tag=lh.admin_controller,limit=1] run tellraw @s [{text:'[赌命德州扑克] ',color:'red'},{text:'附近没有正在运行的赌命德州牌桌。',color:'yellow'}]
execute as @e[tag=lh.admin_controller,limit=1] at @s run function liars_holdem:game/abort
tag @e[tag=lh.admin_controller] remove lh.admin_controller
tag @s remove lh.admin
