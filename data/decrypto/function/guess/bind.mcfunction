scoreboard players set #guess_phase dc_ctx 0
execute unless entity @s[tag=dc.player,tag=ct.player] run return 0
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[tag=ct.paused_return] run return 0
execute unless score @s dc_id = @s ct_id run return 0
scoreboard players operation #ctx dc_ctx = @s dc_id
tag @e[tag=dc.guess_table] remove dc.guess_table
execute as @e[type=minecraft:marker,tag=dc.controller,scores={dc_state=5..8}] if score @s dc_id = #ctx dc_ctx unless score @s ct_paused matches 1 run tag @s add dc.guess_table
execute if entity @e[type=minecraft:marker,tag=dc.guess_table,limit=1] run function decrypto:guess/phase
