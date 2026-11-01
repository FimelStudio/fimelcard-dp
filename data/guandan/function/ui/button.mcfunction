$scoreboard players set #ui_code gd_ctx $(code)
scoreboard players operation #ui_code gd_ctx += #ui_base gd_ctx
execute store result storage guandan:ui code int 1 run scoreboard players get #ui_code gd_ctx
$data modify storage guandan:ui label set value {text:"$(label)",color:"$(color)"}
function guandan:ui/button_append with storage guandan:ui
