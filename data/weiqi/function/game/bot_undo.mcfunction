# 撤回到真人最后一手之前；若人机刚回复，则同时撤回两手。
execute if score @a[tag=go.actor,limit=1] go_side matches 1 unless data entity @s data.weiqi.history[{last:{side:1}}] run return 0
execute if score @a[tag=go.actor,limit=1] go_side matches -1 unless data entity @s data.weiqi.history[{last:{side:-1}}] run return 0
scoreboard players set #undo_twice go_ctx 0
execute if score @s go_turn = @a[tag=go.actor,limit=1] go_side if score @s go_moves matches 2.. run scoreboard players set #undo_twice go_ctx 1
function weiqi:engine/undo
execute if score #undo_twice go_ctx matches 1 run function weiqi:engine/undo
function weiqi:game/clear_requests
function weiqi:visual/refresh
function weiqi:clock/update
function weiqi:ui/refresh
