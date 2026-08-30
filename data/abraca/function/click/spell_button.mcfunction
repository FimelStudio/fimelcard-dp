advancement revoke @s only abraca:click/spell_button
scoreboard players set #button_found ab_ctx 0
execute if entity @e[type=minecraft:interaction,tag=ab.action_button,distance=..6,sort=nearest,limit=1] run scoreboard players set #button_found ab_ctx 1
execute as @e[type=minecraft:interaction,tag=ab.action_button,distance=..6,sort=nearest,limit=1] run scoreboard players operation #ctx ab_ctx = @s ab_id
execute unless score #button_found ab_ctx matches 1 run return 0
execute unless entity @s[tag=ab.turn] run return 0
execute unless score @s ab_id = #ctx ab_ctx run return 0
execute as @e[type=minecraft:interaction,tag=ab.action_button,distance=..6,sort=nearest,limit=1] run scoreboard players operation #choice ab_ctx = @s ct_kind
scoreboard players remove #choice ab_ctx 50
scoreboard players operation @s ab_action = #choice ab_ctx
function abraca:action/handle
