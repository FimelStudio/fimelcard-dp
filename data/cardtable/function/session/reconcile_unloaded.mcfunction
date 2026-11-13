scoreboard players set #round_active ct_ctx 0
execute store result storage cardtable:session round int 1 run scoreboard players get @s ct_session
function cardtable:session/registry_check with storage cardtable:session
execute unless score #round_active ct_ctx matches 1 run function cardtable:game/remove_offline_player
