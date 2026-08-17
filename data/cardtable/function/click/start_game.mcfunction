advancement revoke @s only cardtable:click/start_game
advancement revoke @s only cardtable:click/start_game_attack
function cardtable:log {text:"玩家点击开始游戏文本"}
execute unless entity @s[tag=ct.player] run tellraw @s [{text:'[牌桌] ',color:'dark_aqua'},{text:'请先右键一把空座椅入座。',color:'red'}]
execute unless entity @s[tag=ct.player] run return fail

scoreboard players operation #ctx_id ct_ctx = @s ct_id
tag @s add ct.start_actor
tag @e[tag=ct.start_controller] remove ct.start_controller
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0}] if score @s ct_id = #ctx_id ct_ctx run tag @s add ct.start_controller
execute unless entity @e[tag=ct.start_controller,limit=1] run tellraw @s [{text:'[牌桌] ',color:'dark_aqua'},{text:'没有找到你所在牌桌的大厅控制器，请尝试重新入座。',color:'red'}]
execute unless entity @e[tag=ct.start_controller,limit=1] run tag @s remove ct.start_actor
execute unless entity @e[tag=ct.start_controller,limit=1] run return fail
execute as @e[tag=ct.start_controller,limit=1] at @s run function cardtable:game/start
tag @e[tag=ct.start_controller] remove ct.start_controller
tag @s remove ct.start_actor
