$scoreboard players set #ui_code un_ctx $(code)
scoreboard players operation #ui_code un_ctx += #ui_base un_ctx
execute store result storage uno:ui code int 1 run scoreboard players get #ui_code un_ctx
$data modify storage uno:ui label set value "$(label)"
$data modify storage uno:ui control_color set value "$(color)"
function uno:ui/control_append with storage uno:ui
