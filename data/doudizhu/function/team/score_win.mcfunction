function doudizhu:team/migrate_score
scoreboard players set #winning_team dd_ctx 0
execute as @e[tag=dd.actors] if score @s dd_seat = #winner dd_ctx run scoreboard players operation #winning_team dd_ctx = @s dd_team
scoreboard players set #team_award dd_ctx 1
execute unless score @s dd_scoring matches 1 run scoreboard players operation #team_award dd_ctx = #unit dd_ctx
execute if score #winning_team dd_ctx matches 1 run scoreboard players operation @s dd_team_one += #team_award dd_ctx
execute if score #winning_team dd_ctx matches 2 run scoreboard players operation @s dd_team_two += #team_award dd_ctx
execute if score #winning_team dd_ctx matches 1 run tellraw @a[tag=dd.audience] [{text:"橙队本副得 ",color:"gold"},{score:{name:"#team_award",objective:"dd_ctx"}},{text:" 分。"}]
execute if score #winning_team dd_ctx matches 2 run tellraw @a[tag=dd.audience] [{text:"青队本副得 ",color:"aqua"},{score:{name:"#team_award",objective:"dd_ctx"}},{text:" 分。"}]
execute unless score @s dd_audio matches 0 as @a[tag=dd.audience] if score @s dd_team = #winning_team dd_ctx run function doudizhu:music/start_win
execute unless score @s dd_audio matches 0 as @a[tag=dd.audience] unless score @s dd_team = #winning_team dd_ctx run function doudizhu:music/start_lose
