# 最终排名出现时播放一次明确但不抢占左轮演出的确认和弦
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:block.beacon.power_select player @s ~ ~ ~ 0.55 0.85
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:block.note_block.bell player @s ~ ~ ~ 0.48 1.05
