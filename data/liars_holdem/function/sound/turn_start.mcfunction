# 执行者是当前行动玩家；全桌收到轻提示，当前玩家额外收到高音提示
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:block.note_block.hat player @s ~ ~ ~ 0.16 0.80
playsound minecraft:block.note_block.pling player @s ~ ~ ~ 0.55 1.45
