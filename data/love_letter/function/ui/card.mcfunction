execute unless score #ui_card ll_ctx matches 0..9 run return 0
$scoreboard players set #ui_card_slot ll_ctx $(slot)
$scoreboard players set #ui_code ll_ctx $(offset)
scoreboard players operation #ui_code ll_ctx += #ui_base ll_ctx
execute store result storage love_letter:ui card_code int 1 run scoreboard players get #ui_code ll_ctx
function love_letter:ui/role
data modify storage love_letter:ui card_font set value "card:love_letter/dialog"
execute if score @s ll_pick = #ui_card_slot ll_ctx run data modify storage love_letter:ui card_font set value "card:love_letter/dialog_selected"
function love_letter:ui/card_append with storage love_letter:ui
