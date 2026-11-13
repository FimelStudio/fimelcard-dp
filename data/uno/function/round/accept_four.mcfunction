scoreboard players operation #seat un_ctx = @s un_challenger
scoreboard players set #amount un_ctx 4
function uno:deck/draw
tellraw @a[tag=un.audience] [{text:'[UNO] 下家接受变色 +4，摸四张并跳过回合。',color:'yellow'}]
scoreboard players operation @s un_turn = @s un_challenger
function uno:round/step
execute if score @s un_winner matches 1..8 run return run function uno:round/win
function uno:round/turn_begin
