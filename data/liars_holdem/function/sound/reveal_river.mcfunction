# 河牌在翻牌声上叠加清晰铃声，提示最后一轮公共牌
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:item.book.page_turn player @s ~ ~ ~ 0.55 1.15
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:block.note_block.bell player @s ~ ~ ~ 0.42 1.15
