scoreboard players operation @s ct_session = #rejoin_session ct_ctx
scoreboard players set @s ct_online 1
scoreboard players set @s ct_rejoin 0
tag @s remove ct.rejoining
function cardtable:seat/mount
