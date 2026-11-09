execute unless entity @s[tag=sp.hud] unless entity @s[tag=sp.owns_hud] run return 0
execute if score @s sp_hpanel matches 1.. run function splendor:hud/empty
execute if score @s fbt_panel = @s sp_hpanel run function splendor:hud/restore
execute if entity @s[tag=sp.owns_hud] run tag @s remove fimel.anim_text.replace.actionbar
tag @s remove sp.owns_hud
tag @s remove sp.hud
scoreboard players reset @s sp_hprev
scoreboard players reset @s sp_htimer
