scoreboard players operation #table ll_ctx = @s ct_id
tag @a[tag=ll.audience] remove ll.audience
tag @e[tag=ll.audience] remove ll.audience
tag @e[tag=ll.board] remove ll.board
tag @e[tag=ll.current] remove ll.current
tag @s add ll.current
execute as @e[type=minecraft:marker,tag=ll.part] if score @s ct_id = #table ll_ctx run tag @s add ll.board
execute as @e[tag=ll.player,tag=ct.player] if score @s ll_table = #table ll_ctx if score @s ct_id = #table ll_ctx run tag @s add ll.audience
