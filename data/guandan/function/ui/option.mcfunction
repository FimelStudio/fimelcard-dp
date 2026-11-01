data modify storage guandan:ui option_label set from storage guandan:ui option.label
scoreboard players operation #ui_code gd_ctx = #ui_option gd_ctx
scoreboard players add #ui_code gd_ctx 1000
scoreboard players operation #ui_code gd_ctx += #ui_base gd_ctx
execute store result storage guandan:ui option_code int 1 run scoreboard players get #ui_code gd_ctx
data modify storage guandan:ui option_color set value "green"
execute unless data storage guandan:ui option{beat:1} run data modify storage guandan:ui option_color set value "dark_gray"
function guandan:ui/option_append with storage guandan:ui
