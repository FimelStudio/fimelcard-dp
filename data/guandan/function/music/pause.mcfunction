# 公共暂停层以本桌控制器调用；不依赖已暂停的游戏 tick。
tag @s add gd.music_suspended
scoreboard players operation #music_table gd_ctx = @s ct_id
execute as @a[tag=gd.player,tag=ct.player] if score @s ct_id = #music_table gd_ctx if score @s gd_table = #music_table gd_ctx run function guandan:music/stop
