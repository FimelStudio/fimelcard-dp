function weiqi:game/actor_guard
execute unless score #actor_ok go_ctx matches 1 run return 0
execute unless score @s go_state matches 3 run return 0
scoreboard players set @s go_state 1
scoreboard players set @s go_passes 0
scoreboard players set @e[tag=go.board] go_dead 0
function weiqi:game/clear_requests
function weiqi:visual/refresh
function weiqi:clock/update
function weiqi:ui/refresh
tellraw @a[tag=go.audience] {"text": "[围棋] 已恢复对局，死子标记与确认已清除，保留当前棋形、轮次和超级劫历史。", "color": "yellow"}
