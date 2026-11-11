execute at @s run function avalon:name/resolve
data modify storage avalon:heads name set from storage avalon:name resolved
data modify storage avalon:heads uuid set from entity @s UUID
execute store result storage avalon:heads seat int 1 run scoreboard players get @s av_seat
execute store result storage avalon:heads slot int 1 run scoreboard players get #head_slot av_ctx
scoreboard players add #head_slot av_ctx 1
execute as @a[tag=av.head_receiver,limit=1] run function avalon:player/head_item with storage avalon:heads
