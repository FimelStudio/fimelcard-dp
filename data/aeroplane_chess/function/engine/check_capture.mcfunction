scoreboard players operation #enemy ac_ctx = @s ac_color
scoreboard players operation #enemy ac_ctx *= #thirteen ac_ctx
scoreboard players operation #enemy ac_ctx += @s ac_pos
scoreboard players remove #enemy ac_ctx 1
scoreboard players operation #enemy ac_ctx %= #fiftytwo ac_ctx
execute unless score #enemy ac_ctx = #landing ac_ctx run return 0
scoreboard players operation @s ac_prev = @s ac_pos
scoreboard players set @s ac_pos -1
scoreboard players add #captured ac_ctx 1
tag @s add ac.captured
