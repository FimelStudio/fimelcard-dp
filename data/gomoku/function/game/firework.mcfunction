# 优先在获胜真人处庆祝；虚拟对手使用本桌对应阵营的座椅。
scoreboard players set #winner gm_ctx 1
execute if score @s gm_result matches 2 run scoreboard players set #winner gm_ctx -1
scoreboard players set #celebrate gm_ctx 0
execute as @a[tag=gm.audience] if score @s gm_side = #winner gm_ctx if score #celebrate gm_ctx matches 0 at @s run function gomoku:game/firework_player
execute if score #celebrate gm_ctx matches 1 run return 1
function gomoku:system/side_seats
scoreboard players operation #victory_seat gm_ctx = #black_seat gm_ctx
execute if score #winner gm_ctx matches -1 run scoreboard players operation #victory_seat gm_ctx = #white_seat gm_ctx
execute if score #winner gm_ctx matches 1 if score @s ct_capacity matches 4 if score @s gm_black matches 1..4 run scoreboard players operation #victory_seat gm_ctx = @s gm_black
execute if score #winner gm_ctx matches 1 if score @s ct_capacity matches 8 if score @s gm_black matches 1..8 run scoreboard players operation #victory_seat gm_ctx = @s gm_black
execute if score #winner gm_ctx matches -1 if score @s ct_capacity matches 4 if score @s gm_white matches 1..4 run scoreboard players operation #victory_seat gm_ctx = @s gm_white
execute if score #winner gm_ctx matches -1 if score @s ct_capacity matches 8 if score @s gm_white matches 1..8 run scoreboard players operation #victory_seat gm_ctx = @s gm_white
execute as @e[type=minecraft:interaction,tag=ct.seat] if score @s ct_id = #table gm_ctx if score @s ct_seat = #victory_seat gm_ctx if score #celebrate gm_ctx matches 0 at @s run function gomoku:game/firework_player
execute if score #celebrate gm_ctx matches 0 run function gomoku:game/firework_fallback
