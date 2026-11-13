scoreboard players set #guess_invalid dc_ctx 0
execute unless entity @s[scores={dc_g1=1..4,dc_g2=1..4,dc_g3=1..4}] run scoreboard players set #guess_invalid dc_ctx 1
execute if score @s dc_g1 = @s dc_g2 run scoreboard players set #guess_invalid dc_ctx 1
execute if score @s dc_g1 = @s dc_g3 run scoreboard players set #guess_invalid dc_ctx 1
execute if score @s dc_g2 = @s dc_g3 run scoreboard players set #guess_invalid dc_ctx 1
execute if score #guess_invalid dc_ctx matches 1 run return run function decrypto:guess/render
data modify storage decrypto:guess answer set value [0,0,0]
execute store result storage decrypto:guess answer[0] int 1 run scoreboard players get @s dc_g1
execute store result storage decrypto:guess answer[1] int 1 run scoreboard players get @s dc_g2
execute store result storage decrypto:guess answer[2] int 1 run scoreboard players get @s dc_g3
execute store result storage decrypto:guess phase int 1 run scoreboard players get #guess_phase dc_ctx
scoreboard players reset @s dc_gserial
scoreboard players set @s dc_gp 0
dialog clear @s
clear @s minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:"guess"}}]
tag @a[tag=dc.sync_submitter] remove dc.sync_submitter
tag @s add dc.sync_submitter
execute as @e[type=minecraft:marker,tag=dc.guess_table,limit=1] at @s run function decrypto:guess/commit
tag @s remove dc.sync_submitter
