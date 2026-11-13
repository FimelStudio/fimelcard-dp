execute if score @s ct_joined matches 1..3 if score @s dd_mode matches 0 run return 1
execute if score @s ct_joined matches 1..4 if score @s dd_mode matches 1 run return 1
execute if score @s ct_joined matches 1..8 if score @s dd_mode matches 2 if score @s ct_capacity matches 8 run return 1
execute if score @s dd_mode matches 0 run tellraw @a[tag=ct.start_actor,limit=1] {text:"经典模式需要1至3名真人。请调整入座人数，或在游戏设置切换模式。",color:"red"}
execute if score @s dd_mode matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {text:"2v2需要1至4名真人。请调整入座人数，或在游戏设置切换模式。",color:"red"}
execute if score @s dd_mode matches 2 run tellraw @a[tag=ct.start_actor,limit=1] {text:"4v4需要八座桌，至少1名真人入座。",color:"red"}
return fail
