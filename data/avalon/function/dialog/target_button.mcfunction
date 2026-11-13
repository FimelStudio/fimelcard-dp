scoreboard players operation #button av_ctx = #nonce av_ctx
scoreboard players add #button av_ctx 50
scoreboard players operation #button av_ctx += @s av_seat
execute store result storage avalon:ui button int 1 run scoreboard players get #button av_ctx
execute store result storage avalon:ui seat int 1 run scoreboard players get @s av_seat
data modify storage avalon:ui mark set value "刺杀目标："
function avalon:dialog/append_person with storage avalon:ui
