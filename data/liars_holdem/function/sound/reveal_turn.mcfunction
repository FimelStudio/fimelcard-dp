# 转牌使用单张翻牌声和较低的确认音
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:item.book.page_turn player @s ~ ~ ~ 0.50 1.05
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:block.note_block.pling player @s ~ ~ ~ 0.28 0.90
