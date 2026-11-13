execute unless score @s av_state matches 1..4 run return 0
function avalon:context
tellraw @a[tag=av.audience] {text:"阿瓦隆结束：好人阵营获胜！",color:"green",bold:true}
function cardtable:game/result/title {audience:"@a[tag=av.audience]",title:{text:"好人阵营获胜",color:"green",bold:true},subtitle:{selector:"@a[tag=av.audience,scores={av_role=1..3}]",separator:{text:"、"}}}
function avalon:game/finish
