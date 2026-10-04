scoreboard players set @s ab_timer 0
scoreboard players operation #ctx ab_ctx = @s ab_id
execute as @a[tag=ab.deal_receiver] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.deal_receiver
scoreboard players set #found ab_ctx 0
function abraca:deal/scan_once
execute if score #found ab_ctx matches 0 run function abraca:deal/scan_once
execute if score #found ab_ctx matches 0 run function abraca:deal/scan_once
execute if score #found ab_ctx matches 0 run function abraca:deal/scan_once
execute if score #found ab_ctx matches 0 run function abraca:deal/scan_once
execute if score #found ab_ctx matches 0 run function abraca:deal/scan_once
execute if score #found ab_ctx matches 0 run function abraca:deal/scan_once
execute if score #found ab_ctx matches 0 run function abraca:deal/scan_once
execute unless score #found ab_ctx matches 1 run function abraca:game/abort
execute unless score #found ab_ctx matches 1 run return 0
function abraca:deck/deal_one
scoreboard players add @s ab_deal 1
scoreboard players operation #need ab_ctx = @s ct_joined
scoreboard players set #five ab_ctx 5
scoreboard players operation #need ab_ctx *= #five ab_ctx
execute if score @s ab_deal >= #need ab_ctx run function abraca:deal/finish
