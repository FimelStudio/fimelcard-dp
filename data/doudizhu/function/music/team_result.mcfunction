execute if score @s dd_audio matches 0 run return 0
execute unless score #music_winner dd_ctx matches 1..2 run return 0
execute as @a[tag=dd.audience,scores={dd_team=1..2}] if score @s dd_team = #music_winner dd_ctx run function doudizhu:music/start_win
execute as @a[tag=dd.audience,scores={dd_team=1..2}] unless score @s dd_team = #music_winner dd_ctx run function doudizhu:music/start_lose
