# 击发声只发送给本桌玩家；目标本人额外收到受伤声
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.gun_target] if score @s lh_id = #ctx_id lh_ctx at @s as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run playsound minecraft:entity.firework_rocket.large_blast player @s ~ ~ ~ 0.95 0.62
execute as @a[tag=lh.gun_target] if score @s lh_id = #ctx_id lh_ctx at @s as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run playsound minecraft:entity.generic.explode player @s ~ ~ ~ 0.62 0.82
execute as @a[tag=lh.gun_target] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:entity.player.hurt player @s ~ ~ ~ 0.75 0.80
