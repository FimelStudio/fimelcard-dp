# 五张盖牌从桌心展开时播放纸牌滑动与轻微落桌声
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:item.book.page_turn player @s ~ ~ ~ 0.50 0.80
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:block.amethyst_block.hit player @s ~ ~ ~ 0.24 0.70
