execute if score @s ac_state matches 5 run return 0
function aeroplane_chess:system/context
scoreboard players set @s ac_state 5
scoreboard players set @s ac_timer 100
scoreboard players add @s ac_epoch 1
scoreboard players set @e[tag=ac.board] ac_legal 0
function aeroplane_chess:visual/refresh
function aeroplane_chess:visual/select
function aeroplane_chess:sound/end
function aeroplane_chess:log {text:"对局结算，保留终局棋面"}
tellraw @a[tag=ac.audience] {"text": "[飞行棋] 本局结束，5 秒后返回大厅。", "color": "yellow"}
function aeroplane_chess:ui/refresh
