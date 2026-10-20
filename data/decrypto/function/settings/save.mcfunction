# 锁定本次提交值并立即归零，避免后续刻重复处理。
scoreboard players operation #settings_rounds dc_ctx = @s dc_settings
scoreboard players set @s dc_settings 0
# 编码：回合数×1000+输入方式×100+组队方式×10+8；拒绝旧设置窗口。
execute unless score #settings_rounds dc_ctx matches 1008..32118 run return fail
scoreboard players set #settings_ten dc_ctx 10
scoreboard players operation #settings_marker dc_ctx = #settings_rounds dc_ctx
scoreboard players operation #settings_marker dc_ctx %= #settings_ten dc_ctx
execute unless score #settings_marker dc_ctx matches 8 run return fail
scoreboard players operation #settings_rounds dc_ctx /= #settings_ten dc_ctx
scoreboard players operation #settings_teams dc_ctx = #settings_rounds dc_ctx
scoreboard players operation #settings_teams dc_ctx %= #settings_ten dc_ctx
scoreboard players operation #settings_rounds dc_ctx /= #settings_ten dc_ctx
execute unless score #settings_teams dc_ctx matches 0..1 run return fail
scoreboard players operation #settings_input dc_ctx = #settings_rounds dc_ctx
scoreboard players operation #settings_input dc_ctx %= #settings_ten dc_ctx
scoreboard players operation #settings_rounds dc_ctx /= #settings_ten dc_ctx
execute unless score #settings_input dc_ctx matches 0..1 run return fail
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
execute as @e[tag=dc.settings_controller,limit=1] run scoreboard players operation @s dc_input = #settings_input dc_ctx
execute as @e[tag=dc.settings_controller,limit=1] run scoreboard players operation @s dc_team_mode = #settings_teams dc_ctx
execute if score #settings_teams dc_ctx matches 0 run tellraw @s {text:'组队方式：随机组队（开局随机分队，整局保持不变）。',color:'green'}
execute if score #settings_teams dc_ctx matches 1 run tellraw @s {text:'组队方式：固定组队（四人桌对座同队；八人桌同边及对边同队，每队2至4人且人数差不超过1人）。',color:'green'}
execute if score #settings_input dc_ctx matches 0 run tellraw @s {text:'提示输入方式：书。',color:'green'}
execute if score #settings_input dc_ctx matches 1 run tellraw @s {text:'提示输入方式：对话框（加密者提交需要OP权限）。',color:'yellow'}
tellraw @s [{text:'[谍报风云] ',color:'aqua'},{text:'当前牌桌的分队模式（4至8人）回合数已设为 ',color:'green'},{score:{name:'#settings_rounds',objective:'dc_ctx'},color:'yellow'},{text:' 轮。',color:'green'}]
tag @e[tag=dc.settings_controller] remove dc.settings_controller
tag @s remove ct.settings_actor
scoreboard players set @s dc_set_table 0
