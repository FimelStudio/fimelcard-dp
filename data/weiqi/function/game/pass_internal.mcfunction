function weiqi:system/context
function weiqi:engine/pass
function weiqi:game/clear_requests
function weiqi:sound/pass
execute if score @s go_turn matches -1 run tellraw @a[tag=go.audience] {text:"[围棋] 黑方停一手。",color:"yellow"}
execute if score @s go_turn matches 1 run tellraw @a[tag=go.audience] {text:"[围棋] 白方停一手。",color:"yellow"}
execute if score @s go_passes matches 2.. run return run function weiqi:game/start_scoring
function weiqi:clock/update
function weiqi:ui/refresh
