scoreboard players set @s hb_timer 0
scoreboard players set #found hb_ctx 0
tag @a[tag=hb.deal_receiver] remove hb.deal_receiver
function hanabi:deal/scan_once
execute if score #found hb_ctx matches 0 run function hanabi:deal/scan_once
execute if score #found hb_ctx matches 0 run function hanabi:deal/scan_once
execute if score #found hb_ctx matches 0 run function hanabi:deal/scan_once
execute unless score #found hb_ctx matches 1 run return fail

function hanabi:deal/one
scoreboard players add @s hb_deal 1
execute if score @s hb_deal >= @s hb_total run function hanabi:deal/finish

