# 等待判定期间的低音机械节拍；调用频率由gun/tick限制为每秒一次
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.gun_target] if score @s lh_id = #ctx_id lh_ctx at @s as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run playsound minecraft:block.tripwire.click_off player @s ~ ~ ~ 0.26 0.65
