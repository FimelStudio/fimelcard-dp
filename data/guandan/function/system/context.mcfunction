scoreboard players operation #table gd_ctx = @s ct_id
tag @e[tag=gd.current] remove gd.current
tag @e[tag=gd.board] remove gd.board
tag @e[tag=gd.cards] remove gd.cards
tag @e[tag=gd.audience] remove gd.audience
tag @s add gd.current
execute as @e[type=minecraft:marker,tag=gd.part] if score @s ct_id = #table gd_ctx run tag @s add gd.board
execute as @e[type=minecraft:marker,tag=gd.card] if score @s ct_id = #table gd_ctx run tag @s add gd.cards
execute as @a[tag=gd.player,tag=ct.player] if score @s gd_table = #table gd_ctx if score @s ct_id = #table gd_ctx run tag @s add gd.audience
