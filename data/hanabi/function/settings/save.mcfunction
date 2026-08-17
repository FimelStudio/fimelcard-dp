# 当前执行者是提交hb_settings的玩家；先保存并清零，避免后续刻重复处理
scoreboard players operation #settings_encoded hb_ctx = @s hb_settings
scoreboard players set @s hb_settings 0
scoreboard players operation #settings_table_id hb_ctx = @s hb_set_table

# 编码为“彩色风暴位 + 失误位 + 提示上限”；提示上限为1位或2位
scoreboard players set #ten hb_ctx 10
scoreboard players set #hundred hb_ctx 100
scoreboard players set #thousand hb_ctx 1000
scoreboard players operation #settings_storm hb_ctx = #settings_encoded hb_ctx
scoreboard players operation #settings_strikes hb_ctx = #settings_encoded hb_ctx
scoreboard players operation #settings_clues hb_ctx = #settings_encoded hb_ctx
execute if score #settings_encoded hb_ctx matches 100..999 run scoreboard players operation #settings_storm hb_ctx /= #hundred hb_ctx
execute if score #settings_encoded hb_ctx matches 100..999 run scoreboard players operation #settings_strikes hb_ctx %= #hundred hb_ctx
execute if score #settings_encoded hb_ctx matches 100..999 run scoreboard players operation #settings_strikes hb_ctx /= #ten hb_ctx
execute if score #settings_encoded hb_ctx matches 100..999 run scoreboard players operation #settings_clues hb_ctx %= #ten hb_ctx
execute if score #settings_encoded hb_ctx matches 1000..9999 run scoreboard players operation #settings_storm hb_ctx /= #thousand hb_ctx
execute if score #settings_encoded hb_ctx matches 1000..9999 run scoreboard players operation #settings_strikes hb_ctx %= #thousand hb_ctx
execute if score #settings_encoded hb_ctx matches 1000..9999 run scoreboard players operation #settings_strikes hb_ctx /= #hundred hb_ctx
execute if score #settings_encoded hb_ctx matches 1000..9999 run scoreboard players operation #settings_clues hb_ctx %= #hundred hb_ctx
scoreboard players remove #settings_storm hb_ctx 1

# 提交者必须仍坐在打开设置时的原牌桌
execute unless entity @s[type=minecraft:player,tag=ct.player] run return fail
execute unless score @s ct_id = #settings_table_id hb_ctx run tellraw @s [{text:'[花火] ',color:'light_purple'},{text:'你已经离开或切换了原牌桌，设置未保存。',color:'red'}]
execute unless score @s ct_id = #settings_table_id hb_ctx run return fail
execute unless score #settings_storm hb_ctx matches 0..1 run tellraw @s [{text:'[花火] ',color:'light_purple'},{text:'彩色风暴提交值无效，设置未保存。',color:'red'}]
execute unless score #settings_storm hb_ctx matches 0..1 run return fail
execute unless score #settings_strikes hb_ctx matches 1..9 run tellraw @s [{text:'[花火] ',color:'light_purple'},{text:'失误次数必须是1至9，设置未保存。',color:'red'}]
execute unless score #settings_strikes hb_ctx matches 1..9 run return fail
execute unless score #settings_clues hb_ctx matches 1..32 run tellraw @s [{text:'[花火] ',color:'light_purple'},{text:'提示上限必须是1至32，设置未保存。',color:'red'}]
execute unless score #settings_clues hb_ctx matches 1..32 run return fail

# 原牌桌必须仍在大厅且仍选择花火
tag @s add ct.settings_actor
tag @e[tag=ct.settings_controller] remove ct.settings_controller
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0,ct_game=3}] if score @s ct_id = #settings_table_id hb_ctx run tag @s add ct.settings_controller
execute unless entity @e[tag=ct.settings_controller,limit=1] run tellraw @s [{text:'[花火] ',color:'light_purple'},{text:'原牌桌已开始游戏、切换游戏或被移除，设置未保存。',color:'red'}]
execute unless entity @e[tag=ct.settings_controller,limit=1] run tag @s remove ct.settings_actor
execute unless entity @e[tag=ct.settings_controller,limit=1] run return fail

execute as @e[tag=ct.settings_controller,limit=1] at @s run function hanabi:settings/apply
tag @e[tag=ct.settings_controller] remove ct.settings_controller
tag @s remove ct.settings_actor
scoreboard players set @s hb_set_table 0
