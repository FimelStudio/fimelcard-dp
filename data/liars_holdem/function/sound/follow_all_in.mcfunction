# 跟随ALL IN使用锁链与低音筹码声，区别于普通跟注
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.action_actor] if score @s lh_id = #ctx_id lh_ctx at @s as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run playsound minecraft:block.chain.place player @s ~ ~ ~ 0.50 0.85
execute as @a[tag=lh.action_actor] if score @s lh_id = #ctx_id lh_ctx at @s as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run playsound minecraft:entity.experience_orb.pickup player @s ~ ~ ~ 0.32 0.75
