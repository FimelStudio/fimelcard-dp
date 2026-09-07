tag @e[tag=dc.current] remove dc.current
execute as @e[type=minecraft:marker,tag=dc.controller,scores={dc_state=5..8}] if score @s dc_id = #ctx dc_ctx run tag @s add dc.current
execute unless entity @e[tag=dc.current,limit=1] run return 0
scoreboard players set #authorized dc_ctx 0
execute if entity @e[tag=dc.current,scores={dc_state=5,dc_mode=4}] if entity @s[scores={dc_team=2,dc_encoder=0}] run scoreboard players set #authorized dc_ctx 1
execute if entity @e[tag=dc.current,scores={dc_state=5,dc_mode=3}] if entity @s[scores={dc_team=2}] run scoreboard players set #authorized dc_ctx 1
execute if entity @e[tag=dc.current,scores={dc_state=6,dc_mode=4}] if entity @s[scores={dc_team=1,dc_encoder=0}] run scoreboard players set #authorized dc_ctx 1
execute if entity @e[tag=dc.current,scores={dc_state=6,dc_mode=3}] if entity @s[scores={dc_team=1,dc_encoder=0}] run scoreboard players set #authorized dc_ctx 1
execute if entity @e[tag=dc.current,scores={dc_state=7}] if entity @s[scores={dc_team=1,dc_encoder=0}] run scoreboard players set #authorized dc_ctx 1
execute if entity @e[tag=dc.current,scores={dc_state=8}] if entity @s[scores={dc_team=2,dc_encoder=0}] run scoreboard players set #authorized dc_ctx 1
execute unless score #authorized dc_ctx matches 1 run tag @e[tag=dc.current] remove dc.current
execute unless score #authorized dc_ctx matches 1 run return 0
kill @e[type=minecraft:item,tag=dc.guess_drop,limit=1]
function decrypto:input/give_guess
function decrypto:dialog/digits
tag @e[tag=dc.current] remove dc.current
