# 数字按牌面值；功能牌 20，万能牌 50。末张罚牌已处理后才到这里。
execute if score @s un_state matches 5..6 run return 0
execute unless score @s un_winner matches 1..8 run return fail
scoreboard players set @s un_state 5
scoreboard players set @s un_timer 100
scoreboard players set #u_points un_ctx 0
execute as @e[type=minecraft:marker,tag=un.cards,scores={un_owner=1..8}] run function uno:round/count_points
scoreboard players operation @s un_points = #u_points un_ctx
scoreboard players operation #u_winner un_ctx = @s un_winner
execute as @e[tag=un.audience] if score @s un_seat = #u_winner un_ctx run scoreboard players operation @s un_score += #u_points un_ctx
execute as @a[tag=un.audience] if score @s un_seat = #u_winner un_ctx run tellraw @a[tag=un.audience] [{text:'[UNO] ',color:'gold'},{selector:'@s',color:'aqua'},{text:' 出完手牌，赢得本局！本局得分 '},{score:{name:'#u_points',objective:'un_ctx'},color:'yellow'},{text:'。'}]
scoreboard players set @s un_matchend 0
execute if score @s un_mode matches 0 run scoreboard players set @s un_matchend 1
execute if score @s un_mode matches 1 if score @s un_round >= @s un_rounds run scoreboard players set @s un_matchend 1
scoreboard players operation #u_target un_ctx = @s un_target
execute if score @s un_mode matches 2 as @e[tag=un.audience] if score @s un_score >= #u_target un_ctx run scoreboard players set @e[tag=un.current,limit=1] un_matchend 1
function uno:firework/winner
function uno:system/advance
function uno:log {text:"小局结束，完成剩余手牌计分"}
