scoreboard players operation #table ac_ctx = @s ct_id
tag @e[tag=ac.current] remove ac.current
tag @e[tag=ac.board] remove ac.board
tag @e[tag=ac.sides] remove ac.sides
tag @e[tag=ac.audience] remove ac.audience
tag @a[tag=ac.audience] remove ac.audience
tag @s add ac.current
execute as @e[type=minecraft:marker,tag=ac.plane] if score @s ct_id = #table ac_ctx run tag @s add ac.board
execute as @e[type=minecraft:marker,tag=ac.side] if score @s ct_id = #table ac_ctx run tag @s add ac.sides
execute as @e[tag=ac.player,tag=ct.player] if score @s ac_table = #table ac_ctx if score @s ct_id = #table ac_ctx run tag @s add ac.audience
