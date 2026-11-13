execute as @e[tag=ll.inventory_controller,limit=1] run function love_letter:system/context
clear @s *[minecraft:custom_data~{love_letter:{hand:1b}}]
scoreboard players set #head_index ll_ctx 0
tag @a[tag=ll.head_actor] remove ll.head_actor
tag @s add ll.head_actor
execute as @a[tag=ll.audience] at @s run function love_letter:targeting/head_data
function love_letter:targeting/cancel_item with storage love_letter:input
tag @a[tag=ll.head_actor] remove ll.head_actor
