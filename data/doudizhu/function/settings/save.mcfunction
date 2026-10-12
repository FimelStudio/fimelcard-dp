# 玩家提交；先消费输入，拒绝跨桌、开局后或已切换游戏的旧窗口。
scoreboard players operation #set_rounds dd_ctx = @s dd_settings
scoreboard players reset @s dd_settings
scoreboard players set #set_table dd_ctx 0
scoreboard players operation #set_table dd_ctx = @s dd_set_table
scoreboard players reset @s dd_set_table
execute unless entity @s[tag=ct.player] run return 0
execute unless score @s ct_id = #set_table dd_ctx run return run function doudizhu:settings/invalid
execute unless score #set_rounds dd_ctx matches 1..32 run return run function doudizhu:settings/invalid
tag @e[tag=dd.settings_table] remove dd.settings_table
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0,ct_game=10}] if score @s ct_id = #set_table dd_ctx run tag @s add dd.settings_table
execute unless entity @e[tag=dd.settings_table,limit=1] run return run function doudizhu:settings/invalid
scoreboard players operation @e[tag=dd.settings_table,limit=1] dd_max = #set_rounds dd_ctx
tellraw @s [{text:"[斗地主] 本场局数已设为 ",color:"gold"},{score:{name:"#set_rounds",objective:"dd_ctx"}},{text:" 局，每局分数累计。",color:"gray"}]
tag @e[tag=dd.settings_table] remove dd.settings_table
