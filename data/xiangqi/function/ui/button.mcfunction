$scoreboard players set #ui_code xq_ctx $(code)
scoreboard players operation #ui_code xq_ctx += #ui_base xq_ctx
execute store result storage xiangqi:ui code int 1 run scoreboard players get #ui_code xq_ctx
$data modify storage xiangqi:ui label set value "$(label)"
$data modify storage xiangqi:ui color set value "$(color)"
function xiangqi:ui/button_append with storage xiangqi:ui
