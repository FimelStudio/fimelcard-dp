# 消费一次提交，校验玩家所属牌桌及大厅状态。
scoreboard players operation #set_goal ab_ctx = @s ab_settings
scoreboard players reset @s ab_settings
scoreboard players set #set_table ab_ctx 0
scoreboard players operation #set_table ab_ctx = @s ab_set_table
scoreboard players reset @s ab_set_table
execute unless entity @s[tag=ct.player] run return 0
execute unless score @s ct_id = #set_table ab_ctx run return 0
execute unless score #set_goal ab_ctx matches 1..32 run return 0
tag @e[tag=ab.settings_table] remove ab.settings_table
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0,ct_game=4}] if score @s ct_id = #set_table ab_ctx run tag @s add ab.settings_table
execute unless entity @e[tag=ab.settings_table,limit=1] run return run tellraw @s {text:"设置未保存：牌桌已开始游戏或切换了游戏，请重新打开设置。",color:"yellow"}
scoreboard players operation @e[tag=ab.settings_table,limit=1] ab_goal = #set_goal ab_ctx
tellraw @s [{text:"[出包魔法师] 获胜分数已设为 ",color:"green"},{score:{name:"#set_goal",objective:"ab_ctx"}},{text:" 分。",color:"green"}]
tag @e[tag=ab.settings_table] remove ab.settings_table
