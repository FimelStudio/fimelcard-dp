scoreboard players set #form_ok wq_ctx 0
tag @e[tag=wq.form_controller] remove wq.form_controller
execute unless entity @s[type=minecraft:player,tag=wq.player,scores={wq_guess=0,wq_done=0}] run return 0
execute unless score @s ct_id = @s wq_id run return 0
scoreboard players operation #form_table wq_ctx = @s wq_id
execute as @e[type=minecraft:marker,tag=wq.controller,scores={wq_state=2,wq_input=1}] if score @s wq_id = #form_table wq_ctx run tag @s add wq.form_controller
execute if entity @e[tag=wq.form_controller,limit=1] run scoreboard players set #form_ok wq_ctx 1
