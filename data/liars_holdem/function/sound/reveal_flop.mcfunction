# 翻牌圈一次翻三张，用三个错开的音高模拟连续翻牌
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:item.book.page_turn player @s ~ ~ ~ 0.30 0.85
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:item.book.page_turn player @s ~ ~ ~ 0.30 1.05
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:item.book.page_turn player @s ~ ~ ~ 0.30 1.25
