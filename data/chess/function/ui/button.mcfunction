$scoreboard players set #ui_code ch_ctx $(code)
scoreboard players operation #ui_code ch_ctx += #ui_base ch_ctx
execute store result storage chess:ui code int 1 run scoreboard players get #ui_code ch_ctx
$data modify storage chess:ui label set value "$(label)"
$data modify storage chess:ui color set value "$(color)"
function chess:ui/button_append with storage chess:ui
