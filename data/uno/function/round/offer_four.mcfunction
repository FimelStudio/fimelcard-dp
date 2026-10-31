scoreboard players operation @s un_challenger = @s un_turn
execute if score @s un_challenge matches 0 run return run function uno:round/accept_four
scoreboard players set @s un_state 4
scoreboard players set @s un_drew 0
scoreboard players set @s un_drawn 0
scoreboard players operation #u_turn un_ctx = @s un_challenger
execute as @a[tag=un.audience] if score @s un_seat = #u_turn un_ctx run tellraw @s [{text:'[UNO] 你收到变色 +4。按 Q 选择接受罚四张，或质疑对方当时仍有当前颜色牌。',color:'yellow'}]
tellraw @a[tag=un.audience] [{text:'[UNO] 等待下家接受或质疑变色 +4。',color:'gold'}]
function uno:log {text:"进入变色 +4 接受或质疑阶段"}
function uno:system/advance
