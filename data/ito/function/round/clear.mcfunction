scoreboard players set @s it_state 3
scoreboard players set @s it_timer 60
tellraw @a[tag=it.audience] {"text":"[命悬一线] 本关通过！3秒后进入下一关。","color":"green"}
