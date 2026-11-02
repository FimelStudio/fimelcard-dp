execute unless data storage catan:layout c8o1.hexes run function catan:visual/load
scoreboard players operation #vis_table ca_ctx = @s ct_id
execute store result storage catan:visual cap int 1 run scoreboard players get @s ct_capacity
execute store result storage catan:visual orient int 1 run scoreboard players get @s ca_orient
function catan:visual/layout with storage catan:visual
tag @a[tag=ca.vview] remove ca.vview
execute as @a[tag=ca.player,tag=ct.player] if score @s ca_table = #vis_table ca_ctx if score @s ct_id = #vis_table ca_ctx run tag @s add ca.vview
