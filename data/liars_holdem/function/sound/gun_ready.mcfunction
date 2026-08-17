# 左轮演出开始时，全桌从目标座位听到机械上膛声，目标本人额外听到心跳
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.gun_target] if score @s lh_id = #ctx_id lh_ctx at @s as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run playsound minecraft:block.dispenser.dispense player @s ~ ~ ~ 0.72 0.55
execute as @a[tag=lh.gun_target] if score @s lh_id = #ctx_id lh_ctx at @s as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run playsound minecraft:block.iron_trapdoor.close player @s ~ ~ ~ 0.48 0.62
execute as @a[tag=lh.gun_target] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:entity.warden.heartbeat player @s ~ ~ ~ 0.48 0.65
