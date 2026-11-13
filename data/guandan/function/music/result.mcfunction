scoreboard players operation #music_winner gd_ctx = @s gd_winner
execute if score @s gd_state matches 5 run scoreboard players operation #music_winner gd_ctx = @s gd_matchwin
# 固定副数平局停背景音乐；胜负曲只放一次，不在时长归零后循环。
execute unless score #music_winner gd_ctx matches 0..1 as @a[tag=gd.audience] if score @s gd_music matches 1.. run function guandan:music/stop
execute unless score #music_winner gd_ctx matches 0..1 run return 0
execute as @a[tag=gd.audience] if score @s gd_team = #music_winner gd_ctx unless score @s gd_music matches 3 run function guandan:music/start_win
execute as @a[tag=gd.audience] unless score @s gd_team = #music_winner gd_ctx unless score @s gd_music matches 4 run function guandan:music/start_lose
