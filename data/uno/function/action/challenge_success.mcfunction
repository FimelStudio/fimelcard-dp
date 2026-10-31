scoreboard players operation #seat un_ctx = @s un_offender
scoreboard players set #amount un_ctx 4
function uno:deck/draw
scoreboard players set @s un_winner 0
tellraw @a[tag=un.audience] [{text:'[UNO] 质疑成功：出牌者当时仍有当前颜色牌，罚摸四张；质疑者正常行动。',color:'yellow'}]
scoreboard players operation @s un_turn = @s un_challenger
function uno:round/turn_begin
