function weiqi:engine/undo
function weiqi:game/clear_requests
scoreboard players set @e[tag=go.board] go_dead 0
function weiqi:visual/undo
function weiqi:visual/refresh
function weiqi:clock/update
function weiqi:ui/refresh
tellraw @a[tag=go.audience] {"text": "[围棋] 已撤回最后一手，恢复对应棋形、时钟、提子与超级劫历史。", "color": "yellow"}
