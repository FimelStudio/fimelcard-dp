# @s 为玩家；只允许本桌本阶段加密者访问己方密码。
scoreboard players set #form_ok dc_ctx 0
tag @e[tag=dc.form_controller] remove dc.form_controller
execute unless entity @s[type=minecraft:player,tag=dc.player,scores={dc_encoder=1}] run return 0
execute unless score @s ct_id = @s dc_id run return 0
scoreboard players operation #ctx dc_ctx = @s dc_id
execute if score @s dc_team matches 1 as @e[type=minecraft:marker,tag=dc.controller,scores={dc_state=2,dc_input=1}] if score @s dc_id = #ctx dc_ctx run tag @s add dc.form_controller
execute if score @s dc_team matches 2 as @e[type=minecraft:marker,tag=dc.controller,scores={dc_state=4,dc_input=1}] if score @s dc_id = #ctx dc_ctx run tag @s add dc.form_controller
execute if entity @e[tag=dc.form_controller,limit=1] run scoreboard players set #form_ok dc_ctx 1
