scoreboard players operation #setting it_ctx = @s it_settings
scoreboard players set @s it_settings 0
scoreboard players set #ten it_ctx 10
scoreboard players operation #mode it_ctx = #setting it_ctx
scoreboard players operation #mode it_ctx %= #ten it_ctx
scoreboard players operation #setting it_ctx /= #ten it_ctx
execute unless score #mode it_ctx matches 1..2 run return 0
execute unless score #setting it_ctx = @s it_setnonce run return 0
execute unless entity @s[tag=ct.player] run return 0
execute unless score @s ct_id = @s it_settable run return 0
scoreboard players operation #settings_table it_ctx = @s it_settable
scoreboard players remove #mode it_ctx 1
scoreboard players set #saved it_ctx 0
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=19,ct_state=0}] if score @s ct_id = #settings_table it_ctx run function ito:settings/apply
execute if score #saved it_ctx matches 0 run tellraw @s {text:"牌桌已开始或切换游戏，设置未保存。",color:"red"}
execute if score #saved it_ctx matches 1 if score #mode it_ctx matches 0 run tellraw @s {text:"[命悬一线] 输入方式已设为：书本。",color:"green"}
execute if score #saved it_ctx matches 1 if score #mode it_ctx matches 1 run tellraw @s {text:"[命悬一线] 输入方式已设为：对话框。按Q使用紫色染料自行打开。",color:"green"}
function ito:settings/clear_session
