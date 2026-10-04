function decrypto:prompt/authorize
execute unless score #form_ok dc_ctx matches 1 run return 0
scoreboard players set #form_table dc_ctx -1
scoreboard players set #form_token dc_ctx -1
execute store result score #form_table dc_ctx run data get storage decrypto:form incoming.t
execute store result score #form_token dc_ctx run data get storage decrypto:form incoming.n
execute unless score @s dc_id = #form_table dc_ctx run return run function decrypto:prompt/expired
execute unless score @e[tag=dc.form_controller,limit=1] dc_form = #form_token dc_ctx run return run function decrypto:prompt/expired
scoreboard players set #form_length dc_ctx 0
execute store result score #form_length dc_ctx run data get storage decrypto:form incoming.a
execute unless score #form_length dc_ctx matches 1..24 run return run function decrypto:prompt/invalid
scoreboard players set #form_length dc_ctx 0
execute store result score #form_length dc_ctx run data get storage decrypto:form incoming.b
execute unless score #form_length dc_ctx matches 1..24 run return run function decrypto:prompt/invalid
scoreboard players set #form_length dc_ctx 0
execute store result score #form_length dc_ctx run data get storage decrypto:form incoming.c
execute unless score #form_length dc_ctx matches 1..24 run return run function decrypto:prompt/invalid
clear @s minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:'prompt'}}]
tellraw @s {text:'[谍报风云] 三条提示已提交。',color:'green'}
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.6 1.4
execute as @e[tag=dc.form_controller,limit=1] at @s run function decrypto:prompt/accept
tag @e[tag=dc.form_controller] remove dc.form_controller
data remove storage decrypto:form incoming
