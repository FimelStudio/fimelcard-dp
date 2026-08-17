# 当前执行者是提交fc_settings trigger的玩家；先复制输入并归零，防止失败值在后续刻重复处理
scoreboard players operation #settings_encoded fc_ctx = @s fc_settings
scoreboard players set @s fc_settings 0
scoreboard players operation #settings_table_id fc_ctx = @s fc_set_table

# trigger把规则放在十进制首位：1表示乱按忽略，2表示乱按立即判负；后续1至3位为局数
scoreboard players operation #settings_rounds fc_ctx = #settings_encoded fc_ctx
scoreboard players set #settings_rule fc_ctx -1
execute if score #settings_encoded fc_ctx matches 11..19 run scoreboard players set #settings_rule fc_ctx 0
execute if score #settings_encoded fc_ctx matches 110..199 run scoreboard players set #settings_rule fc_ctx 0
execute if score #settings_encoded fc_ctx matches 1100..1999 run scoreboard players set #settings_rule fc_ctx 0
execute if score #settings_encoded fc_ctx matches 21..29 run scoreboard players set #settings_rule fc_ctx 1
execute if score #settings_encoded fc_ctx matches 210..299 run scoreboard players set #settings_rule fc_ctx 1
execute if score #settings_encoded fc_ctx matches 2100..2999 run scoreboard players set #settings_rule fc_ctx 1
execute if score #settings_encoded fc_ctx matches 11..19 run scoreboard players remove #settings_rounds fc_ctx 10
execute if score #settings_encoded fc_ctx matches 110..199 run scoreboard players remove #settings_rounds fc_ctx 100
execute if score #settings_encoded fc_ctx matches 1100..1999 run scoreboard players remove #settings_rounds fc_ctx 1000
execute if score #settings_encoded fc_ctx matches 21..29 run scoreboard players remove #settings_rounds fc_ctx 20
execute if score #settings_encoded fc_ctx matches 210..299 run scoreboard players remove #settings_rounds fc_ctx 200
execute if score #settings_encoded fc_ctx matches 2100..2999 run scoreboard players remove #settings_rounds fc_ctx 2000

# 提交者必须仍坐在打开设置时的同一张牌桌
execute unless entity @s[type=minecraft:player,tag=ct.player] run return fail
execute unless score @s ct_id = #settings_table_id fc_ctx run tellraw @s [{text:'[Fast Card] ',color:'gold'},{text:'你已经离开或切换了原牌桌，设置未保存。',color:'red'}]
execute unless score @s ct_id = #settings_table_id fc_ctx run return fail
execute unless score #settings_rule fc_ctx matches 0..1 run tellraw @s [{text:'[Fast Card] ',color:'gold'},{text:'设置提交值无效，设置未保存。',color:'red'}]
execute unless score #settings_rule fc_ctx matches 0..1 run return fail
execute unless score #settings_rounds fc_ctx matches 1..999 run tellraw @s [{text:'[Fast Card] ',color:'gold'},{text:'局数必须是1至999的整数，设置未保存。',color:'red'}]
execute unless score #settings_rounds fc_ctx matches 1..999 run return fail

# 原牌桌还必须处于大厅且仍选择Fast Card
tag @s add ct.settings_actor
tag @e[tag=ct.settings_controller] remove ct.settings_controller
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0,ct_game=1}] if score @s ct_id = #settings_table_id fc_ctx run tag @s add ct.settings_controller
execute unless entity @e[tag=ct.settings_controller,limit=1] run tellraw @s [{text:'[Fast Card] ',color:'gold'},{text:'原牌桌已开始游戏、切换游戏或被移除，设置未保存。',color:'red'}]
execute unless entity @e[tag=ct.settings_controller,limit=1] run tag @s remove ct.settings_actor
execute unless entity @e[tag=ct.settings_controller,limit=1] run return fail

execute as @e[tag=ct.settings_controller,limit=1] at @s run function fast_card:settings/apply
tag @e[tag=ct.settings_controller] remove ct.settings_controller
tag @s remove ct.settings_actor
scoreboard players set @s fc_set_table 0
