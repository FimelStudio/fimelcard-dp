# 换牌候选是私密信息，只向打开Dialog的玩家播放
execute as @a[tag=lh.swap_actor] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:item.book.page_turn player @s ~ ~ ~ 0.55 1.45
execute as @a[tag=lh.swap_actor] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:block.chest.open player @s ~ ~ ~ 0.22 1.65
