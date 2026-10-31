# 新增人机与走格提示，保留现有双人局面和设置。
scoreboard objectives add ch_bot dummy
scoreboard objectives add ch_level dummy
scoreboard objectives add ch_hints dummy
scoreboard objectives add ch_aistate dummy
scoreboard objectives add ch_aiwait dummy
scoreboard objectives add ch_aiepoch dummy
execute as @e[tag=ch.controller] run scoreboard players set @s ch_bot 0
execute as @e[tag=ch.controller] run scoreboard players set @s ch_level 2
execute as @e[tag=ch.controller] run scoreboard players set @s ch_hints 1
scoreboard players set #version ch_ctx 3
