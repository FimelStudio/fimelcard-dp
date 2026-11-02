# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set #ballot_table av_ctx -1
scoreboard players set #ballot_epoch av_ctx -1
scoreboard players set #ballot_code av_ctx -1
execute store result score #ballot_table av_ctx run data get entity @s Item.components."minecraft:custom_data".avalon.table
execute store result score #ballot_epoch av_ctx run data get entity @s Item.components."minecraft:custom_data".avalon.epoch
execute store result score #ballot_code av_ctx run data get entity @s Item.components."minecraft:custom_data".avalon.code
execute on origin if entity @s[tag=av.player,tag=ct.player] at @s run function avalon:input/ballot
kill @s
