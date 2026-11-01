scoreboard players set @s it_state 4
scoreboard players set @s it_timer 100
execute as @a[tag=it.audience] run clear @s *[minecraft:custom_data~{ito:{tool:1b}}]
execute as @a[tag=it.audience] run dialog clear @s
function ito:visual/refresh
function ito:hud/refresh
