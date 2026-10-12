tag @s add dd.actor
tag @s add dd.bot
scoreboard players operation @s dd_id = #ctx dd_ctx
$scoreboard players set @s dd_seat $(seat)
$data merge entity @s {CustomName:{text:"测试人机$(seat)",color:"aqua"}}
scoreboard players set @s dd_plays 0
scoreboard players set @s dd_points 0
scoreboard players set @s dd_total 0
