$scoreboard players set #ui_code ca_ctx $(code)
scoreboard players operation #ui_code ca_ctx += #ui_base ca_ctx
execute store result storage catan:ui code int 1 run scoreboard players get #ui_code ca_ctx
$data modify storage catan:ui label set value "$(label)"
$data modify storage catan:ui color set value "$(color)"
function catan:ui/button_append with storage catan:ui
