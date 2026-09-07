scoreboard players operation #choice dc_ctx = @s dc_action
scoreboard players set @s dc_action 0
execute unless score #choice dc_ctx matches 101..104 run return 0
scoreboard players operation #ctx dc_ctx = @s dc_id
tag @e[tag=dc.current] remove dc.current
execute as @e[type=minecraft:marker,tag=dc.controller] if score @s dc_id = #ctx dc_ctx run tag @s add dc.current
execute unless entity @e[tag=dc.current,limit=1] run return 0
execute if entity @e[tag=dc.current,scores={dc_state=1,dc_mode=4}] unless entity @s[scores={dc_seat=1}] run return 0
execute if entity @e[tag=dc.current,scores={dc_state=1,dc_mode=3}] unless entity @s[scores={dc_encoder=1}] run return 0
execute if entity @e[tag=dc.current,scores={dc_state=3}] unless entity @s[scores={dc_seat=3}] run return 0
execute if entity @e[tag=dc.current,scores={dc_state=5,dc_mode=4}] unless entity @s[scores={dc_team=2,dc_encoder=0}] run return 0
execute if entity @e[tag=dc.current,scores={dc_state=5,dc_mode=3}] unless entity @s[scores={dc_team=2}] run return 0
execute if entity @e[tag=dc.current,scores={dc_state=6..7,dc_mode=4}] unless entity @s[scores={dc_team=1,dc_encoder=0}] run return 0
execute if entity @e[tag=dc.current,scores={dc_state=6,dc_mode=3}] if entity @s[scores={dc_encoder=1}] run return 0
execute if entity @e[tag=dc.current,scores={dc_state=8,dc_mode=4}] unless entity @s[scores={dc_team=2,dc_encoder=0}] run return 0
execute unless entity @e[tag=dc.current,scores={dc_state=1..8}] run return 0
scoreboard players remove #choice dc_ctx 100
tag @s add dc.actor
execute as @e[tag=dc.current] at @s run function decrypto:action/save_digit
tag @s remove dc.actor
tag @e[tag=dc.current] remove dc.current
