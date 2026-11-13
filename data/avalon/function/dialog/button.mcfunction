scoreboard players operation #button av_ctx = #nonce av_ctx
$scoreboard players add #button av_ctx $(code)
execute store result storage avalon:ui button int 1 run scoreboard players get #button av_ctx
$data modify storage avalon:ui label set value "$(label)"
function avalon:dialog/append_button with storage avalon:ui
