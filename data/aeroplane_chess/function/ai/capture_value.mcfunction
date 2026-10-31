scoreboard players operation #enemy ac_ctx = @s ac_color
scoreboard players operation #enemy ac_ctx *= #thirteen ac_ctx
scoreboard players operation #enemy ac_ctx += @s ac_pos
scoreboard players remove #enemy ac_ctx 1
scoreboard players operation #enemy ac_ctx %= #fiftytwo ac_ctx
execute if score #enemy ac_ctx = #landing ac_ctx run scoreboard players add #value ac_ctx 180
