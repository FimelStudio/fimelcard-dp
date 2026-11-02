tag @a[tag=it.winner] remove it.winner
function ito:red/top
function ito:red/top
tellraw @a[tag=it.audience] [{text:"红线结束，获胜者：",color:"gold"},{selector:"@a[tag=it.winner]"}]
function ito:game/finish
tag @a[tag=it.winner] remove it.winner
