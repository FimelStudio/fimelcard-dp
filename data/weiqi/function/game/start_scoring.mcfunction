scoreboard players set @s go_state 3
scoreboard players set @s go_bconfirm 0
scoreboard players set @s go_wconfirm 0
execute if score @s go_bot matches 1 run scoreboard players set @s go_bconfirm 1
execute if score @s go_bot matches -1 run scoreboard players set @s go_wconfirm 1
scoreboard players set @e[tag=go.board] go_dead 0
function weiqi:engine/score
scoreboard players add @s go_epoch 1
function weiqi:visual/estimate
function weiqi:sound/score
function weiqi:clock/update
function weiqi:ui/refresh
tellraw @a[tag=go.audience] {"text": "[围棋] 计分已暂停棋钟。右键棋子整组标记／取消死子，双方确认后才结算；有争议可恢复对局。面积计分不额外累加提子。", "color": "yellow"}
