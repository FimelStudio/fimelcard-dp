scoreboard objectives add dd_music dummy
scoreboard objectives add dd_mtime dummy
# 停止旧音符盒版本，避免热重载时残留音符；不再调度旧曲谱。
execute unless data storage doudizhu:music {resource_audio:1b} run function doudizhu:music/migrate
# 重载后重启背景音乐，避免客户端播放进度与计时不同步。
execute as @a[scores={dd_music=1..}] run function doudizhu:music/stop
