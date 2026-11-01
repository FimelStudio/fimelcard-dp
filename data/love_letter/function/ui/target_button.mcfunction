execute unless score #ui_role ll_ctx matches 5 if score @s ll_seat = #ui_seat ll_ctx run return 0
scoreboard players operation #ui_code ll_ctx = @s ll_seat
scoreboard players add #ui_code ll_ctx 100
scoreboard players operation #ui_code ll_ctx += #ui_base ll_ctx
execute store result storage love_letter:ui code int 1 run scoreboard players get #ui_code ll_ctx
execute store result storage love_letter:ui seat int 1 run scoreboard players get @s ll_seat
data modify storage love_letter:ui label set from entity @s data.ll_name
function love_letter:ui/target_append with storage love_letter:ui
