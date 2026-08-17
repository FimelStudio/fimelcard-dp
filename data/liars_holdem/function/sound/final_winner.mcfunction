# 最终胜利声在枪声之后延迟播放；全桌听到信标，幸存者听到完整胜利提示
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:block.beacon.activate player @s ~ ~ ~ 0.60 0.85
execute as @a[tag=lh.player,scores={lh_alive=1}] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:ui.toast.challenge_complete player @s ~ ~ ~ 0.75 1.00
execute as @a[tag=lh.player,scores={lh_alive=1}] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:entity.player.levelup player @s ~ ~ ~ 0.60 1.20
