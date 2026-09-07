scoreboard players operation #ctx cp_ctx = @s cp_id
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run function critical_point:player/clear_state
tag @s remove cp.controller
scoreboard players reset @s cp_id
scoreboard players reset @s cp_state
scoreboard players reset @s cp_round
scoreboard players reset @s cp_threshold
scoreboard players reset @s cp_timer
scoreboard players reset @s cp_vote_used
function cardtable:game/return_lobby
