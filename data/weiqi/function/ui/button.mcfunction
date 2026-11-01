$scoreboard players set #ui_code go_ctx $(code)
scoreboard players operation #ui_code go_ctx += #ui_base go_ctx
execute store result storage weiqi:ui code int 1 run scoreboard players get #ui_code go_ctx
$data modify storage weiqi:ui label set value "$(label)"
$data modify storage weiqi:ui color set value "$(color)"
function weiqi:ui/button_append with storage weiqi:ui
