# 固化秒数，避免跨桌共用缓冲区导致显示串桌。
execute store result storage decrypto:timer display.seconds int 1 run scoreboard players get @s dc_seconds
function decrypto:title/timer_text with storage decrypto:timer display
