# 玩家执行，旧窗口、跨桌及进行中的牌局均拒绝。
scoreboard players operation #skin_choice ct_ctx = @s ct_skin_pick
scoreboard players reset @s ct_skin_pick
execute unless entity @s[tag=ct.player] run return 0
execute unless score @s ct_id = @s ct_skin_table run return 0
scoreboard players operation #skin_table ct_ctx = @s ct_skin_table
scoreboard players reset @s ct_skin_table
execute unless score #skin_choice ct_ctx matches 1..4 run return 0
tag @e[tag=ct.skin_controller] remove ct.skin_controller
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0}] if score @s ct_id = #skin_table ct_ctx run tag @s add ct.skin_controller
execute unless entity @e[tag=ct.skin_controller,limit=1] run return 0
tag @s add ct.settings_actor
execute if score #skin_choice ct_ctx matches 3 as @e[tag=ct.skin_controller,limit=1] at @s run function cardtable:skin/open
execute if score #skin_choice ct_ctx matches 1..2 as @e[tag=ct.skin_controller,limit=1] at @s run function cardtable:skin/select
execute if score #skin_choice ct_ctx matches 4 as @e[tag=ct.skin_controller,limit=1] at @s run function cardtable:skin/picker
tag @s remove ct.settings_actor
tag @e[tag=ct.skin_controller] remove ct.skin_controller
