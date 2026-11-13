# 流局仍消耗一副牌。四人局直接轮换，双桌局留在结算状态等另一桌。
scoreboard players set @s dd_state 4
scoreboard players set @s dd_timer 0
scoreboard players set @s dd_void 1
scoreboard players set @s dd_side_score 0
function doudizhu:player/audience
execute if score @s dd_lane matches 1..2 as @a[tag=dd.audience] run function doudizhu:music/stop
execute if score @s dd_lane matches 1..2 run tellraw @a[tag=dd.audience] {text:"[斗地主] 本桌流局，等待双桌结算。",color:"yellow"}
execute unless score @s dd_lane matches 1..2 run tellraw @a[tag=dd.audience] {text:"[斗地主] 本副流局。",color:"yellow"}
execute as @a[tag=dd.audience] run dialog clear @s
function doudizhu:input/sync
function doudizhu:system/refresh
