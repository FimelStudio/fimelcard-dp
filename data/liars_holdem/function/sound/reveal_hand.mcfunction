# 每名玩家的最佳五张牌出现时，从该玩家座位方向播放亮牌声
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.reveal_actor] if score @s lh_id = #ctx_id lh_ctx at @s as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run playsound minecraft:item.book.page_turn player @s ~ ~ ~ 0.52 0.95
execute as @a[tag=lh.reveal_actor] if score @s lh_id = #ctx_id lh_ctx at @s as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run playsound minecraft:block.amethyst_block.chime player @s ~ ~ ~ 0.32 1.05
