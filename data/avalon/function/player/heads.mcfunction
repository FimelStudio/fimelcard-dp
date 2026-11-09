execute unless score @s av_state matches 1 run return 0
tag @a[tag=av.head_receiver] remove av.head_receiver
scoreboard players operation #leader av_ctx = @s av_leader
execute as @a[tag=av.audience] if score @s av_seat = #leader av_ctx run tag @s add av.head_receiver
execute store result storage avalon:heads table int 1 run scoreboard players get @s av_id
execute store result storage avalon:heads epoch int 1 run scoreboard players get @s av_epoch
execute as @a[tag=av.audience] run function avalon:player/head_data
tag @a[tag=av.head_receiver] remove av.head_receiver
