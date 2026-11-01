# 玩家执行：先消费一次提交，再校验窗口、本人桌号及大厅状态。
scoreboard players operation #pick_choice ct_ctx = @s ct_game_pick
scoreboard players operation #pick_choice ct_ctx -= @s ct_pick_base
scoreboard players reset @s ct_game_pick
execute unless entity @s[tag=ct.player] run return run function cardtable:menu/picker/invalid
execute unless score @s ct_pick_table = @s ct_id run return run function cardtable:menu/picker/invalid
execute unless score #pick_choice ct_ctx matches 1..20 run return run function cardtable:menu/picker/invalid
# unregistered-id 19
execute if score #pick_choice ct_ctx matches 19 run return run function cardtable:menu/picker/invalid
scoreboard players operation #pick_table ct_ctx = @s ct_pick_table
tag @a[tag=ct.switch_actor] remove ct.switch_actor
tag @e[tag=ct.switch_controller] remove ct.switch_controller
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0}] if score @s ct_id = #pick_table ct_ctx run tag @s add ct.switch_controller
execute unless entity @e[tag=ct.switch_controller,limit=1] run return run function cardtable:menu/picker/invalid
scoreboard players reset @s ct_pick_table
scoreboard players reset @s ct_pick_base
tag @s add ct.switch_actor
execute as @e[tag=ct.switch_controller,limit=1] at @s run function cardtable:menu/select_game
tag @e[tag=ct.switch_controller] remove ct.switch_controller
tag @s remove ct.switch_actor
