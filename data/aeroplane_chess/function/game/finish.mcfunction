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
execute if score @s ac_winner matches 0 run function cardtable:game/result/title {audience:"@a[tag=ac.audience]",title:{text:"红方获胜",color:"red",bold:true},subtitle:{selector:"@a[tag=ac.audience,scores={ac_color=0}]"}}
execute if score @s ac_winner matches 1 run function cardtable:game/result/title {audience:"@a[tag=ac.audience]",title:{text:"蓝方获胜",color:"blue",bold:true},subtitle:{selector:"@a[tag=ac.audience,scores={ac_color=1}]"}}
execute if score @s ac_winner matches 2 run function cardtable:game/result/title {audience:"@a[tag=ac.audience]",title:{text:"绿方获胜",color:"green",bold:true},subtitle:{selector:"@a[tag=ac.audience,scores={ac_color=2}]"}}
execute if score @s ac_winner matches 3 run function cardtable:game/result/title {audience:"@a[tag=ac.audience]",title:{text:"黄方获胜",color:"yellow",bold:true},subtitle:{selector:"@a[tag=ac.audience,scores={ac_color=3}]"}}
function aeroplane_chess:ui/refresh
