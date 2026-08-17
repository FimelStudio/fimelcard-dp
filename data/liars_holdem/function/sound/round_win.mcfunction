# 无需比牌便直接获胜时，全桌收到短胜利提示，胜者额外收到升级音
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:block.note_block.chime player @s ~ ~ ~ 0.55 1.25
execute as @a[tag=lh.round_winner] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:entity.player.levelup player @s ~ ~ ~ 0.60 1.20
