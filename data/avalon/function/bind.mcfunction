tag @e[tag=av.current] remove av.current
scoreboard players operation #table av_ctx = @s av_id
execute as @e[type=minecraft:marker,tag=av.controller] if score @s av_id = #table av_ctx run tag @s add av.current
