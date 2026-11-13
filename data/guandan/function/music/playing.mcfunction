scoreboard players set #music_mode gd_ctx 1
execute if entity @s[tag=gd.music_exciting] run scoreboard players set #music_mode gd_ctx 2
execute as @a[tag=gd.audience] unless score @s gd_music = #music_mode gd_ctx run function guandan:music/sync_playing
execute as @a[tag=gd.audience,scores={gd_music=1,gd_mtime=..0}] run function guandan:music/start_normal
execute as @a[tag=gd.audience,scores={gd_music=2,gd_mtime=..0}] run function guandan:music/start_exciting
