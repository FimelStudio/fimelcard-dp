execute unless data storage guandan:ui options[0] run return 0
data modify storage guandan:ui option set from storage guandan:ui options[0]
data remove storage guandan:ui options[0]
function guandan:ui/option with storage guandan:ui option
scoreboard players add #ui_option gd_ctx 1
function guandan:ui/option_next
