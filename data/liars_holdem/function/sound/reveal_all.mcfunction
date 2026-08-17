# ALL IN后一次翻开剩余公共牌，使用更紧张的低音收束行动阶段
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:item.book.page_turn player @s ~ ~ ~ 0.65 0.90
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:block.note_block.bass player @s ~ ~ ~ 0.65 0.55
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:block.amethyst_block.chime player @s ~ ~ ~ 0.38 0.75
