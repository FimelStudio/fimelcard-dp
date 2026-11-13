scoreboard players operation #table ma_ctx = @s ma_table
execute as @e[tag=ma.cell_preview] if score @s ct_id = #table ma_ctx run kill @s
execute as @e[tag=ma.pool] if score @s ct_id = #table ma_ctx run data merge entity @s {Glowing:0b}
execute as @e[tag=ma.racer] if score @s ct_id = #table ma_ctx run data merge entity @s {Glowing:0b}
scoreboard players operation #selected ma_ctx = @s ma_confirm
execute if score #selected ma_ctx matches 100..135 run scoreboard players remove #selected ma_ctx 100
execute as @e[tag=ma.pool] if score @s ct_id = #table ma_ctx if score @s ma_did = #selected ma_ctx run data merge entity @s {Glowing:1b,glow_color_override:5636095}
scoreboard players operation #selected ma_ctx = @s ma_confirm
scoreboard players remove #selected ma_ctx 2100
execute unless data entity @e[tag=ma.current,limit=1] data.magical_athlete.pending{kind:"thirdwheel"} as @e[tag=ma.racer] if score @s ct_id = #table ma_ctx if score @s ma_vid = #selected ma_ctx run data merge entity @s {Glowing:1b,glow_color_override:5636095}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.pending{kind:"thirdwheel"} if score #selected ma_ctx matches 0..30 as @e[tag=ma.current,limit=1] at @s run function magical_athlete:direct/cell_highlight
