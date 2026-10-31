execute store result storage uno:ui code int 1 run scoreboard players get #ui_colorcode un_ctx
$data modify storage uno:ui label set value "$(name)"
$data modify storage uno:ui control_color set value "$(color)"
function uno:ui/color_append with storage uno:ui
