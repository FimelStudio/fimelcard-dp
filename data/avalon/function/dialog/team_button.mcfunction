scoreboard players operation #button av_ctx = #nonce av_ctx
scoreboard players operation #button av_ctx += @s av_seat
execute store result storage avalon:ui button int 1 run scoreboard players get #button av_ctx
execute store result storage avalon:ui seat int 1 run scoreboard players get @s av_seat
data modify storage avalon:ui mark set value "□ "
execute if score @s av_selected matches 1 run data modify storage avalon:ui mark set value "✓ "
function avalon:dialog/append_person with storage avalon:ui
