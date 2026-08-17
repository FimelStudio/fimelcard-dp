# 当前执行者是提交设置的玩家；先锁定值并归零防止重复处理
scoreboard players operation #settings_value lh_ctx = @s lh_settings
scoreboard players set @s lh_settings 0
scoreboard players operation #settings_table lh_ctx = @s lh_set_table

execute unless entity @s[tag=ct.player] run return fail
execute unless score @s ct_id = #settings_table lh_ctx run tellraw @s [{text:'[赌命德州扑克] ',color:'red'},{text:'你已经离开原牌桌，设置未保存。',color:'yellow'}]
execute unless score @s ct_id = #settings_table lh_ctx run return fail
execute unless score #settings_value lh_ctx matches 1..5 run tellraw @s [{text:'[赌命德州扑克] ',color:'red'},{text:'等待时间只能是1至5秒。',color:'yellow'}]
execute unless score #settings_value lh_ctx matches 1..5 run return fail

tag @s add ct.settings_actor
tag @e[tag=lh.settings_controller] remove lh.settings_controller
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0,ct_game=2}] if score @s ct_id = #settings_table lh_ctx run tag @s add lh.settings_controller
execute unless entity @e[tag=lh.settings_controller,limit=1] run tellraw @s [{text:'[赌命德州扑克] ',color:'red'},{text:'原牌桌已开始游戏、切换游戏或被移除。',color:'yellow'}]
execute unless entity @e[tag=lh.settings_controller,limit=1] run tag @s remove ct.settings_actor
execute unless entity @e[tag=lh.settings_controller,limit=1] run return fail

execute as @e[tag=lh.settings_controller,limit=1] run scoreboard players operation @s lh_gun_time = #settings_value lh_ctx
execute as @e[tag=lh.settings_controller,limit=1] at @s run function liars_holdem:log {text:"已保存开枪占位演出等待时间"}
tellraw @s [{text:'[赌命德州扑克] ',color:'red'},{text:'设置已保存：开枪结果等待 ',color:'green'},{score:{name:'#settings_value',objective:'lh_ctx'},color:'yellow'},{text:' 秒。',color:'green'}]
tag @e[tag=lh.settings_controller] remove lh.settings_controller
tag @s remove ct.settings_actor
scoreboard players set @s lh_set_table 0
