execute if score @s ll_panel matches 1.. run function love_letter:hud/empty
execute if entity @s[tag=ll.hud_active] if score @s fbt_panel = @s ll_panel run function love_letter:hud/restore
execute if entity @s[tag=ll.owns_actionbar] run tag @s remove fimel.anim_text.replace.actionbar
tag @s remove ll.owns_actionbar
tag @s remove ll.hud_active
scoreboard players reset @s ll_prev_panel
