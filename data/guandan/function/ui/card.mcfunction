execute unless score @s gd_strength = #ui_previous gd_ctx run data modify storage guandan:ui stack_columns append value {cards:[]}
execute unless score @s gd_strength = #ui_previous gd_ctx run scoreboard players set #ui_depth gd_ctx 0
scoreboard players operation #ui_type gd_ctx = @s gd_type
function guandan:ui/type
execute if score @s gd_wild matches 1 run data modify storage guandan:ui slices set from storage guandan:ui wild_slices
execute if score @s gd_sel matches 1 run data modify storage guandan:ui slices set from storage guandan:ui selected_slices
execute if score @s gd_sel matches 1 if score @s gd_wild matches 1 run data modify storage guandan:ui slices set from storage guandan:ui selected_wild_slices
scoreboard players operation #ui_code gd_ctx = @s gd_id
scoreboard players add #ui_code gd_ctx 100
scoreboard players operation #ui_code gd_ctx += #ui_base gd_ctx
execute store result storage guandan:ui card_code int 1 run scoreboard players get #ui_code gd_ctx
function guandan:ui/card_append with storage guandan:ui
tag @s remove gd.uicards
scoreboard players add #ui_depth gd_ctx 1
scoreboard players operation #ui_maxdepth gd_ctx > #ui_depth gd_ctx
scoreboard players operation #ui_previous gd_ctx = @s gd_strength
