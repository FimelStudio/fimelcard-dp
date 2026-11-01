function ito:input/focus
execute unless entity @e[tag=it.focus,limit=1] run return 0
execute store result storage ito:ui number int 1 run scoreboard players get @e[tag=it.focus,limit=1] it_number
execute store result storage ito:ui slot int 1 run scoreboard players get #slot it_ctx
function ito:ui/card_label with storage ito:ui
scoreboard players operation #button it_ctx = #base it_ctx
scoreboard players operation #button it_ctx += #slot it_ctx
scoreboard players add #button it_ctx 10
execute if score @e[tag=it.current,limit=1] it_input matches 1 run execute if score @e[tag=it.current,limit=1] it_input matches 1 run function ito:ui/button
function ito:ui/play_label with storage ito:ui
scoreboard players add #button it_ctx 10
function ito:ui/button
