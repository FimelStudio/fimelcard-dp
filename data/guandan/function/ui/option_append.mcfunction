$data modify storage guandan:ui option_button set value {label:{text:"$(option_label)",color:"$(option_color)"},width:220}
execute if data storage guandan:ui option{beat:1} run function guandan:ui/option_command with storage guandan:ui
data modify storage guandan:ui buttons append from storage guandan:ui option_button
