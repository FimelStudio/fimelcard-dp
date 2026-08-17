# 空枪用两层干涩机械声表现，不使用爆炸类音效
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.gun_target] if score @s lh_id = #ctx_id lh_ctx at @s as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run playsound minecraft:block.lever.click player @s ~ ~ ~ 0.90 0.45
execute as @a[tag=lh.gun_target] if score @s lh_id = #ctx_id lh_ctx at @s as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run playsound minecraft:block.tripwire.click_off player @s ~ ~ ~ 0.50 0.80
