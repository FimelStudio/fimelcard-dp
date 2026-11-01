tag @e[tag=gd.selected] remove gd.selected
execute as @e[tag=gd.cards,scores={gd_sel=1}] if score @s gd_owner = #actor gd_ctx run tag @s add gd.selected
