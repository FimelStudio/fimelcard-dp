scoreboard players set #winning_team dd_ctx 0
execute as @e[tag=dd.actors] if score @s dd_seat = #winner dd_ctx run scoreboard players operation #winning_team dd_ctx = @s dd_team
execute if score #winning_team dd_ctx matches 1 run scoreboard players add @s dd_team_one 1
execute if score #winning_team dd_ctx matches 2 run scoreboard players add @s dd_team_two 1
execute if score #winning_team dd_ctx matches 1 run tellraw @a[tag=dd.audience] {text:"橙队赢下一副，得1分。",color:"gold"}
execute if score #winning_team dd_ctx matches 2 run tellraw @a[tag=dd.audience] {text:"青队赢下一副，得1分。",color:"aqua"}
execute unless score @s dd_audio matches 0 as @a[tag=dd.audience] if score @s dd_team = #winning_team dd_ctx run function doudizhu:music/start_win
execute unless score @s dd_audio matches 0 as @a[tag=dd.audience] unless score @s dd_team = #winning_team dd_ctx run function doudizhu:music/start_lose
