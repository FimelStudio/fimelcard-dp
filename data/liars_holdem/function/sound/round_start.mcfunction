# 执行者是本桌控制器；低音与风铃组成新一局的两层提示
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:block.note_block.bass player @s ~ ~ ~ 0.35 0.75
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:block.note_block.chime player @s ~ ~ ~ 0.60 1.15
