# 手牌发完后用收盒声衔接公共牌展开
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:block.chest.close player @s ~ ~ ~ 0.40 1.25
