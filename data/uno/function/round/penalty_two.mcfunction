scoreboard players operation #seat un_ctx = @s un_turn
scoreboard players set #amount un_ctx 2
function uno:deck/draw
tellraw @a[tag=un.audience] [{text:'[UNO] 下家摸两张并跳过回合，罚牌不能叠加。',color:'yellow'}]
function uno:round/step
