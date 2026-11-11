execute unless score @s av_state matches 1 run return 0
tag @a[tag=av.head_receiver] remove av.head_receiver
scoreboard players operation #leader av_ctx = @s av_leader
execute as @a[tag=av.audience] if score @s av_seat = #leader av_ctx run tag @s add av.head_receiver
execute store result storage avalon:heads table int 1 run scoreboard players get @s av_id
execute store result storage avalon:heads epoch int 1 run scoreboard players get @s av_epoch
# 按实际入座人数从快捷栏第一格连续发放，座位空缺不占用格子。
scoreboard players set #head_slot av_ctx 0
scoreboard players set #head_blocked av_ctx 0
scoreboard players operation #head_count av_ctx = @s av_players
execute if score #head_blocked av_ctx matches 0 as @a[tag=av.audience,scores={av_seat=1}] run function avalon:player/head_data
execute if score #head_blocked av_ctx matches 0 as @a[tag=av.audience,scores={av_seat=2}] run function avalon:player/head_data
execute if score #head_blocked av_ctx matches 0 as @a[tag=av.audience,scores={av_seat=3}] run function avalon:player/head_data
execute if score #head_blocked av_ctx matches 0 as @a[tag=av.audience,scores={av_seat=4}] run function avalon:player/head_data
execute if score #head_blocked av_ctx matches 0 as @a[tag=av.audience,scores={av_seat=5}] run function avalon:player/head_data
execute if score #head_blocked av_ctx matches 0 as @a[tag=av.audience,scores={av_seat=6}] run function avalon:player/head_data
execute if score #head_blocked av_ctx matches 0 as @a[tag=av.audience,scores={av_seat=7}] run function avalon:player/head_data
execute if score #head_blocked av_ctx matches 0 as @a[tag=av.audience,scores={av_seat=8}] run function avalon:player/head_data
tag @a[tag=av.head_receiver] remove av.head_receiver
