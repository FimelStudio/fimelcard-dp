# Called at this controller before player identities are cleared.
scoreboard players operation #reveal_table av_ctx = @s av_id
execute as @e[type=minecraft:item_display,tag=av.reveal] if score @s av_id = #reveal_table av_ctx run kill @s
execute as @a[tag=av.audience] run function avalon:reveal/player
