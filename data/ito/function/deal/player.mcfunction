scoreboard players operation #deal_owner it_ctx = @s it_seat
scoreboard players set #deal_slot it_ctx 1
function ito:deal/one
execute if score @e[tag=it.current,limit=1] it_round matches 2.. run function ito:deal/one
execute if score @e[tag=it.current,limit=1] it_round matches 3 run function ito:deal/one
