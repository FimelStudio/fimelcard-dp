# 进入摊牌时降低音高，给逐人亮牌留出听觉空间
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:block.note_block.bass player @s ~ ~ ~ 0.58 0.50
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:block.note_block.bell player @s ~ ~ ~ 0.36 0.75
