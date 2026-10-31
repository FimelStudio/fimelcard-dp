scoreboard players set @s un_state 2
scoreboard players set @s un_drew 0
scoreboard players set @s un_drawn 0
scoreboard players set @s un_pending 0
scoreboard players set @s un_winner 0
scoreboard players operation #u_turn un_ctx = @s un_turn
execute as @a[tag=un.audience] if score @s un_seat = #u_turn un_ctx run tellraw @a[tag=un.audience] [{text:'[UNO] 轮到 ',color:'gold'},{selector:'@s',color:'aqua'},{text:'。',color:'gold'}]
execute as @a[tag=un.audience] if score @s un_seat = #u_turn un_ctx run tellraw @s [{text:'按 Q 打开第一格的 UNO 手牌；选择出牌或摸一张。',color:'yellow'}]
function uno:system/advance
