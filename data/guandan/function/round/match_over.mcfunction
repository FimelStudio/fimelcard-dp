execute if score @s gd_state matches 5 run return 0
scoreboard players set @s gd_state 5
scoreboard players set @s gd_timer 120
scoreboard players operation #match gd_ctx = @s gd_matchwin
execute if score #match gd_ctx matches 2 run tellraw @a[tag=gd.audience] {text:"[掼蛋] 固定副数结束，双方级数相同，本场平局。",color:"gold"}
execute if score #match gd_ctx matches 0..1 run tellraw @a[tag=gd.audience] [{text:"[掼蛋] 本场胜者：第",color:"gold"},{score:{name:"@s",objective:"gd_matchwin"}},{text:"队！"}]
execute as @e[tag=gd.board] if score @s gd_team = #match gd_ctx run function guandan:round/winner
function guandan:sound/end
function guandan:log {text:"掼蛋整场结束，锁定结算并等待返回大厅"}
