$scoreboard players set #ui_code ll_ctx $(code)
scoreboard players operation #ui_code ll_ctx += #ui_base ll_ctx
execute store result storage love_letter:ui code int 1 run scoreboard players get #ui_code ll_ctx
$data modify storage love_letter:ui label set value {text:"$(label)",color:"$(color)"}
function love_letter:ui/button_append with storage love_letter:ui
