execute as @a[tag=ll.audience,tag=ll.aim_preview] unless score @s ll_seat = #aim ll_ctx run effect clear @s minecraft:glowing
execute as @a[tag=ll.audience,tag=ll.aim_preview] unless score @s ll_seat = #aim ll_ctx run tag @s remove ll.aim_preview
execute as @a[tag=ll.audience] if score @s ll_seat = #aim ll_ctx run tag @s add ll.aim_preview
execute as @a[tag=ll.audience,tag=ll.aim_preview] run effect give @s minecraft:glowing 1 0 true
