# 锁定本次提交值并立即归零，避免后续刻重复处理。
scoreboard players operation #settings_rounds dc_ctx = @s dc_settings
scoreboard players set @s dc_settings 0
scoreboard players operation #settings_table dc_ctx = @s dc_set_table

execute unless entity @s[type=minecraft:player,tag=ct.player] run return fail
execute unless score @s ct_id = #settings_table dc_ctx run tellraw @s [{text:'[谍报风云] ',color:'aqua'},{text:'你已经离开或切换了原牌桌，设置未保存。',color:'red'}]
execute unless score @s ct_id = #settings_table dc_ctx run return fail
execute unless score #settings_rounds dc_ctx matches 1..32 run tellraw @s [{text:'[谍报风云] ',color:'aqua'},{text:'回合数必须是1至32的整数，设置未保存。',color:'red'}]
execute unless score #settings_rounds dc_ctx matches 1..32 run return fail

# 原牌桌必须仍在大厅且仍选择谍报风云。
tag @s add ct.settings_actor
tag @e[tag=dc.settings_controller] remove dc.settings_controller
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0,ct_game=6}] if score @s ct_id = #settings_table dc_ctx run tag @s add dc.settings_controller
execute unless entity @e[tag=dc.settings_controller,limit=1] run tellraw @s [{text:'[谍报风云] ',color:'aqua'},{text:'原牌桌已开始游戏、切换游戏或被移除，设置未保存。',color:'red'}]
execute unless entity @e[tag=dc.settings_controller,limit=1] run tag @s remove ct.settings_actor
execute unless entity @e[tag=dc.settings_controller,limit=1] run return fail

execute as @e[tag=dc.settings_controller,limit=1] run scoreboard players operation @s dc_round_limit = #settings_rounds dc_ctx
tellraw @s [{text:'[谍报风云] ',color:'aqua'},{text:'当前牌桌的四人模式回合数已设为 ',color:'green'},{score:{name:'#settings_rounds',objective:'dc_ctx'},color:'yellow'},{text:' 轮。',color:'green'}]
tag @e[tag=dc.settings_controller] remove dc.settings_controller
tag @s remove ct.settings_actor
scoreboard players set @s dc_set_table 0
