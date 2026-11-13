execute if score @s gd_state matches 5 run return 0
scoreboard players set @s gd_state 5
scoreboard players set @s gd_timer 120
scoreboard players operation #match gd_ctx = @s gd_matchwin
execute if score #match gd_ctx matches 2 run tellraw @a[tag=gd.audience] {text:"[掼蛋] 固定副数结束，双方级数相同，本场平局。",color:"gold"}
execute if score #match gd_ctx matches 0..1 run tellraw @a[tag=gd.audience] [{text:"[掼蛋] 本场胜者：第",color:"gold"},{score:{name:"@s",objective:"gd_matchwin"}},{text:"队！"}]
data modify storage cardtable:result names set value {text:"",extra:[]}
execute as @e[tag=gd.board] if score @s gd_team = #match gd_ctx run function guandan:round/winner
execute if score #match gd_ctx matches 2 run function cardtable:game/result/title {audience:"@a[tag=gd.audience]",title:{text:"平局",color:"yellow",bold:true},subtitle:{text:""}}
execute if score #match gd_ctx matches 0..1 run function cardtable:game/result/title {audience:"@a[tag=gd.audience]",title:[{text:"第",color:"gold",bold:true},{score:{name:"@s",objective:"gd_matchwin"},color:"gold",bold:true},{text:"队获胜",color:"gold",bold:true}],subtitle:{nbt:"names",storage:"cardtable:result",interpret:true}}
function guandan:sound/end
function guandan:log {text:"掼蛋整场结束，锁定结算并等待返回大厅"}
