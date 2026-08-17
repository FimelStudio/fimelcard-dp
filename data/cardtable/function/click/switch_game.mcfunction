advancement revoke @s only cardtable:click/switch_game
advancement revoke @s only cardtable:click/switch_game_attack
execute unless entity @s[tag=ct.player] run tellraw @s [{text:'[牌桌] ',color:'dark_aqua'},{text:'请先右键一把空座椅入座。',color:'red'}]
execute unless entity @s[tag=ct.player] run return fail

scoreboard players operation #ctx_id ct_ctx = @s ct_id
tag @s add ct.switch_actor
tag @e[tag=ct.switch_controller] remove ct.switch_controller
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0}] if score @s ct_id = #ctx_id ct_ctx run tag @s add ct.switch_controller
execute as @e[tag=ct.switch_controller,limit=1] at @s run function cardtable:menu/next_game
tag @e[tag=ct.switch_controller] remove ct.switch_controller
tag @s remove ct.switch_actor
