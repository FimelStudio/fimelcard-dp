execute unless entity @e[tag=gd.hudhand] run return 0
scoreboard players set #hud_max gd_ctx -1
execute as @e[tag=gd.hudhand] run scoreboard players operation #hud_max gd_ctx > @s gd_hud_key
execute as @e[tag=gd.hudhand] if score @s gd_hud_key = #hud_max gd_ctx run function guandan:hud/card
function guandan:hud/next_card
