function guandan:system/context
execute if score @s gd_state matches 2 run return run function guandan:tribute/auto
scoreboard players operation #actor gd_ctx = @s gd_turn
execute unless score @s gd_lastkind matches 0 run return run function guandan:game/pass
scoreboard players set @e[tag=gd.cards] gd_sel 0
scoreboard players set #low gd_ctx 99
execute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx run scoreboard players operation #low gd_ctx < @s gd_strength
tag @e[tag=gd.auto] remove gd.auto
execute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx if score @s gd_strength = #low gd_ctx run tag @s add gd.auto
scoreboard players set @e[tag=gd.auto,limit=1] gd_sel 1
function guandan:game/play
tag @e[tag=gd.auto] remove gd.auto
