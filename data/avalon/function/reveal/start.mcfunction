# Called at this controller before player identities are cleared.
scoreboard players operation #reveal_table av_ctx = @s av_id
execute as @e[type=minecraft:item_display,tag=av.reveal] if score @s av_id = #reveal_table av_ctx run kill @s
scoreboard players operation #reveal_c1 av_ctx = @s ct_c1
scoreboard players operation #reveal_c2 av_ctx = @s ct_c2
scoreboard players operation #reveal_c3 av_ctx = @s ct_c3
scoreboard players operation #reveal_c4 av_ctx = @s ct_c4
scoreboard players operation #reveal_c5 av_ctx = @s ct_c5
scoreboard players operation #reveal_c6 av_ctx = @s ct_c6
scoreboard players operation #reveal_c7 av_ctx = @s ct_c7
scoreboard players operation #reveal_c8 av_ctx = @s ct_c8
execute as @a[tag=av.audience] run function avalon:reveal/player
