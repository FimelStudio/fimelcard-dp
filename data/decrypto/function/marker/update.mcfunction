# 在桌心上方显示双方公开战况；每次计分后原地重建。
scoreboard players operation #ctx dc_ctx = @s dc_id
execute as @e[tag=dc.marker] if score @s dc_id = #ctx dc_ctx run kill @s
kill @e[tag=dc.marker,distance=..4]
execute store result storage decrypto:marker wi int 1 run scoreboard players get @s dc_wi
execute store result storage decrypto:marker bi int 1 run scoreboard players get @s dc_bi
execute store result storage decrypto:marker we int 1 run scoreboard players get @s dc_we
execute store result storage decrypto:marker be int 1 run scoreboard players get @s dc_be
execute if score @s dc_mode matches 4 run function decrypto:marker/spawn_four with storage decrypto:marker
execute if score @s dc_mode matches 3 run function decrypto:marker/spawn_three with storage decrypto:marker
scoreboard players operation @e[type=minecraft:text_display,tag=dc.new_marker,distance=..4] dc_id = @s dc_id
tag @e[tag=dc.new_marker,distance=..4] remove dc.new_marker
