data modify storage love_letter:input uuid set from entity @s UUID
function love_letter:name/resolve
data modify storage love_letter:input head_name set from storage love_letter:name resolved
execute store result storage love_letter:input target int 1 run scoreboard players get @s ll_seat
execute store result storage love_letter:input head_slot int 1 run scoreboard players get #head_index ll_ctx
execute as @a[tag=ll.head_actor,limit=1] run function love_letter:targeting/head_item with storage love_letter:input
scoreboard players add #head_index ll_ctx 1
