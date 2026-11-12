scoreboard players set @s ll_aim 0
scoreboard players set @s ll_aimttl 0
execute as @a[tag=ll.audience,tag=ll.aim_preview] run effect clear @s minecraft:glowing
tag @a[tag=ll.audience,tag=ll.aim_preview] remove ll.aim_preview
