scoreboard objectives add gd_audio dummy
scoreboard objectives add gd_music dummy
scoreboard objectives add gd_mtime dummy
# 重载只重启播放，不重置本桌开关、紧张状态或副数。
execute as @a[scores={gd_music=1..}] run function guandan:music/stop
