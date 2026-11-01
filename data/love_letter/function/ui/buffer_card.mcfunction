$execute unless data entity @e[tag=ll.current,limit=1] data.ll_buffer[$(index)] run return 0
$execute store result score #ui_card ll_ctx run data get entity @e[tag=ll.current,limit=1] data.ll_buffer[$(index)]
function love_letter:ui/role
data modify storage love_letter:ui card_font set value "card:love_letter/dialog"
$scoreboard players set #ui_code ll_ctx $(index)
execute if entity @e[tag=ll.current,scores={ll_phase=4},limit=1] run scoreboard players add #ui_code ll_ctx 300
execute if entity @e[tag=ll.current,scores={ll_phase=5},limit=1] run scoreboard players add #ui_code ll_ctx 400
scoreboard players operation #ui_code ll_ctx += #ui_base ll_ctx
execute store result storage love_letter:ui card_code int 1 run scoreboard players get #ui_code ll_ctx
function love_letter:ui/card_append with storage love_letter:ui
