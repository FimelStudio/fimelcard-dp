execute if score @s un_timer matches 1.. run scoreboard players remove @s un_timer 1
execute if score @s un_timer matches 1.. run return 0
scoreboard players set @s un_timer 2
scoreboard players operation #u_total un_ctx = @s un_size
scoreboard players set #u_seven un_ctx 7
scoreboard players operation #u_total un_ctx *= #u_seven un_ctx
execute if score @s un_dealt >= #u_total un_ctx run return run function uno:round/deal_finish
scoreboard players operation #seat un_ctx = @s un_turn
function uno:deck/take
scoreboard players add @s un_dealt 1
function uno:round/step
