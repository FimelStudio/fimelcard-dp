advancement revoke @s only cardtable:click/game_settings
advancement revoke @s only cardtable:click/game_settings_attack
function cardtable:log {text:"玩家点击游戏设置文本"}

execute unless entity @s[tag=ct.player] run tellraw @s [{text:'[牌桌] ',color:'dark_aqua'},{text:'请先右键一把空座椅入座。',color:'red'}]
execute unless entity @s[tag=ct.player] run return fail

scoreboard players operation #ctx_id ct_ctx = @s ct_id
tag @s add ct.settings_actor
tag @e[tag=ct.settings_controller] remove ct.settings_controller
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0}] if score @s ct_id = #ctx_id ct_ctx run tag @s add ct.settings_controller
execute unless entity @e[tag=ct.settings_controller,limit=1] run tellraw @s [{text:'[牌桌] ',color:'dark_aqua'},{text:'没有找到你所在牌桌的大厅控制器，请尝试重新入座。',color:'red'}]
execute unless entity @e[tag=ct.settings_controller,limit=1] run tag @s remove ct.settings_actor
execute unless entity @e[tag=ct.settings_controller,limit=1] run return fail

execute as @e[tag=ct.settings_controller,limit=1] at @s run function cardtable:game/open_settings
tag @e[tag=ct.settings_controller] remove ct.settings_controller
tag @s remove ct.settings_actor
