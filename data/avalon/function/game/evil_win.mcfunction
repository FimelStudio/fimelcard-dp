execute unless score @s av_state matches 1..4 run return 0
function avalon:context
tellraw @a[tag=av.audience] {text:"阿瓦隆结束：坏人阵营获胜！",color:"red",bold:true}
function cardtable:game/result/title {audience:"@a[tag=av.audience]",title:{text:"坏人阵营获胜",color:"red",bold:true},subtitle:{selector:"@a[tag=av.audience,scores={av_role=4..7}]",separator:{text:"、"}}}
function avalon:game/finish
