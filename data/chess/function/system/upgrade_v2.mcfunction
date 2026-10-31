# 兼容制作过程中已加载的早期国际象棋：补新目标，不清空现有棋局。
scoreboard objectives add ch_first dummy
scoreboard objectives add ch_undo dummy
execute as @e[tag=ch.controller] unless score @s ch_first matches 0..1 run scoreboard players set @s ch_first 0
execute as @e[tag=ch.controller] unless score @s ch_undo matches -1..1 run scoreboard players set @s ch_undo 0
scoreboard players set #version ch_ctx 2
