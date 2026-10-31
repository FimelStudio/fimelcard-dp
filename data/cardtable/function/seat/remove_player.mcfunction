execute if score @s ac_setnonce matches 1.. run function aeroplane_chess:settings/clear_session
execute if score @s gm_setnonce matches 1.. run function gomoku:settings/clear_session
execute if score @s xq_setnonce matches 1.. run function xiangqi:input/clear
execute if score @s ch_setnonce matches 1.. run function chess:input/clear
execute if score @s un_setnonce matches 1.. run function uno:settings/clear_session
scoreboard players reset @s ct_skin_pick
scoreboard players reset @s ct_skin_table
ride @s dismount
scoreboard players reset @s ct_game_pick
scoreboard players reset @s ct_pick_table
scoreboard players reset @s ct_pick_base
tag @s remove ct.player
scoreboard players reset @s ct_id
scoreboard players reset @s ct_seat
scoreboard players reset @s ct_voted
scoreboard players reset @s ct_online
