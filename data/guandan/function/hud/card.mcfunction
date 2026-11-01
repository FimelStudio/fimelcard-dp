execute unless score @s gd_strength = #hud_previous gd_ctx run scoreboard players set #hud_depth gd_ctx 0
execute unless score @s gd_strength = #hud_previous gd_ctx run scoreboard players add #hud_groups gd_ctx 1
execute if score @s gd_strength = #hud_previous gd_ctx run data modify storage guandan:hud hand.extra append value {text:"",font:"card:guandan/spacing"}
execute unless score #hud_previous gd_ctx matches -1 unless score @s gd_strength = #hud_previous gd_ctx run data modify storage guandan:hud hand.extra append value {text:"",font:"card:guandan/spacing"}
scoreboard players operation #hud_type gd_ctx = @s gd_type
function guandan:hud/type
execute if score @s gd_point = @e[tag=gd.current,limit=1] gd_level run data modify storage guandan:hud glyph set from storage guandan:hud wild
execute if score @s gd_sel matches 1 run data modify storage guandan:hud glyph set from storage guandan:hud selected
execute if score @s gd_sel matches 1 if score @s gd_point = @e[tag=gd.current,limit=1] gd_level run data modify storage guandan:hud glyph set from storage guandan:hud selected_wild
execute store result storage guandan:hud depth int 1 run scoreboard players get #hud_depth gd_ctx
function guandan:hud/append with storage guandan:hud
tag @s remove gd.hudhand
scoreboard players add #hud_count gd_ctx 1
scoreboard players operation #hud_maxdepth gd_ctx > #hud_depth gd_ctx
scoreboard players operation #hud_previous gd_ctx = @s gd_strength
scoreboard players add #hud_depth gd_ctx 1
