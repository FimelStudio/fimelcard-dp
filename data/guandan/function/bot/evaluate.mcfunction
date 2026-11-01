scoreboard players operation #utility gd_ctx = #size gd_ctx
scoreboard players set #bot_weight gd_ctx 100
scoreboard players operation #utility gd_ctx *= #bot_weight gd_ctx
scoreboard players operation #utility gd_ctx -= #high gd_ctx
execute if score #kind gd_ctx matches 8..10 run scoreboard players remove #utility gd_ctx 2000
scoreboard players set #bot_hand gd_ctx 0
execute as @e[tag=gd.board] if score @s gd_seat = #actor gd_ctx run scoreboard players operation #bot_hand gd_ctx = @s gd_count
execute if score #size gd_ctx = #bot_hand gd_ctx run scoreboard players add #utility gd_ctx 10000
scoreboard players set #bot_team gd_ctx -1
execute as @e[tag=gd.board] if score @s gd_seat = #actor gd_ctx run scoreboard players operation #bot_team gd_ctx = @s gd_team
execute store result score #last_team gd_ctx run data get entity @s data.guandan.bot.partner
execute if score @s gd_lastkind matches 1.. if score #last_team gd_ctx = #bot_team gd_ctx unless score #size gd_ctx = #bot_hand gd_ctx run return 0
execute unless score #utility gd_ctx > @s gd_best run return 0
scoreboard players operation @s gd_best = #utility gd_ctx
scoreboard players operation @s gd_bestchoice = #choice gd_ctx
execute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx run scoreboard players operation @s gd_botpick = @s gd_sel
