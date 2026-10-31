$scoreboard players set #ui_code gm_ctx $(code)
scoreboard players operation #ui_code gm_ctx += #ui_base gm_ctx
execute store result storage gomoku:ui code int 1 run scoreboard players get #ui_code gm_ctx
$data modify storage gomoku:ui label set value "$(label)"
$data modify storage gomoku:ui color set value "$(color)"
function gomoku:ui/button_append with storage gomoku:ui
