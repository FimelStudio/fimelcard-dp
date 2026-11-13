# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tag @a[tag=it.winner] remove it.winner
function ito:red/top
function ito:red/top
tellraw @a[tag=it.audience] [{text:"红线结束，获胜者：",color:"gold"},{selector:"@a[tag=it.winner]"}]
function cardtable:game/result/title {audience:"@a[tag=it.audience]",title:{text:"最终胜利者",color:"gold",bold:true},subtitle:{selector:"@a[tag=it.winner]"}}
function ito:game/finish
tag @a[tag=it.winner] remove it.winner
