execute as @e[tag=gd.cards] if score @s gd_owner = #ui_seat gd_ctx run scoreboard players set @s gd_sel 0
execute as @e[tag=gd.cards] if score @s gd_owner = #ui_seat gd_ctx run tag @s remove gd.selected
