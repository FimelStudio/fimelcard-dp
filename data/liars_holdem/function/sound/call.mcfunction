# 跟注声从行动玩家的位置传来，模拟筹码落桌
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.action_actor] if score @s lh_id = #ctx_id lh_ctx at @s as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run playsound minecraft:block.note_block.hat player @s ~ ~ ~ 0.48 1.30
execute as @a[tag=lh.action_actor] if score @s lh_id = #ctx_id lh_ctx at @s as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run playsound minecraft:entity.experience_orb.pickup player @s ~ ~ ~ 0.30 1.45
