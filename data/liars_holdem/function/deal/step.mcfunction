scoreboard players set @s lh_timer 0
scoreboard players set #found lh_ctx 0
tag @a[tag=lh.deal_receiver] remove lh.deal_receiver
function liars_holdem:deal/scan_once
execute if score #found lh_ctx matches 0 run function liars_holdem:deal/scan_once
execute if score #found lh_ctx matches 0 run function liars_holdem:deal/scan_once
execute if score #found lh_ctx matches 0 run function liars_holdem:deal/scan_once
execute if score #found lh_ctx matches 0 run function liars_holdem:deal/scan_once
execute if score #found lh_ctx matches 0 run function liars_holdem:deal/scan_once
execute if score #found lh_ctx matches 0 run function liars_holdem:deal/scan_once
execute if score #found lh_ctx matches 0 run function liars_holdem:deal/scan_once
execute unless score #found lh_ctx matches 1 run return fail

function liars_holdem:deal/one
scoreboard players add @s lh_deal 1
execute if score @s lh_deal >= @s lh_total run function liars_holdem:deal/finish
