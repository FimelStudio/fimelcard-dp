function avalon:context
scoreboard players set @s av_state 1
scoreboard players set @a[tag=av.audience] av_selected 0
scoreboard players set @a[tag=av.audience] av_vote 0
scoreboard players set @a[tag=av.audience] av_mission 0
execute if score @s av_players matches 5 if score @s av_round matches 1 run scoreboard players set @s av_need 2
execute if score @s av_players matches 5 if score @s av_round matches 2 run scoreboard players set @s av_need 3
execute if score @s av_players matches 5 if score @s av_round matches 3 run scoreboard players set @s av_need 2
execute if score @s av_players matches 5 if score @s av_round matches 4 run scoreboard players set @s av_need 3
execute if score @s av_players matches 5 if score @s av_round matches 5 run scoreboard players set @s av_need 3
execute if score @s av_players matches 6 if score @s av_round matches 1 run scoreboard players set @s av_need 2
execute if score @s av_players matches 6 if score @s av_round matches 2 run scoreboard players set @s av_need 3
execute if score @s av_players matches 6 if score @s av_round matches 3 run scoreboard players set @s av_need 4
execute if score @s av_players matches 6 if score @s av_round matches 4 run scoreboard players set @s av_need 3
execute if score @s av_players matches 6 if score @s av_round matches 5 run scoreboard players set @s av_need 4
execute if score @s av_players matches 7 if score @s av_round matches 1 run scoreboard players set @s av_need 2
execute if score @s av_players matches 7 if score @s av_round matches 2 run scoreboard players set @s av_need 3
execute if score @s av_players matches 7 if score @s av_round matches 3 run scoreboard players set @s av_need 3
execute if score @s av_players matches 7 if score @s av_round matches 4 run scoreboard players set @s av_need 4
execute if score @s av_players matches 7 if score @s av_round matches 5 run scoreboard players set @s av_need 4
execute if score @s av_players matches 8 if score @s av_round matches 1 run scoreboard players set @s av_need 3
execute if score @s av_players matches 8 if score @s av_round matches 2 run scoreboard players set @s av_need 4
execute if score @s av_players matches 8 if score @s av_round matches 3 run scoreboard players set @s av_need 4
execute if score @s av_players matches 8 if score @s av_round matches 4 run scoreboard players set @s av_need 5
execute if score @s av_players matches 8 if score @s av_round matches 5 run scoreboard players set @s av_need 5
function avalon:game/refresh
