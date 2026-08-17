# 牌盒出现时播放轻微的开盒声，音效只发送给本桌玩家
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:block.chest.open player @s ~ ~ ~ 0.45 1.35
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:block.note_block.hat player @s ~ ~ ~ 0.20 0.90
