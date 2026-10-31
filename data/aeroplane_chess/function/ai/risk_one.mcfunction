scoreboard players operation #enemy ac_ctx = @s ac_color
scoreboard players operation #enemy ac_ctx *= #thirteen ac_ctx
scoreboard players operation #enemy ac_ctx += @s ac_pos
scoreboard players remove #enemy ac_ctx 1
scoreboard players operation #enemy ac_ctx %= #fiftytwo ac_ctx
scoreboard players operation #gap ac_ctx = #landing ac_ctx
scoreboard players operation #gap ac_ctx -= #enemy ac_ctx
scoreboard players operation #gap ac_ctx += #fiftytwo ac_ctx
scoreboard players operation #gap ac_ctx %= #fiftytwo ac_ctx
execute if score #gap ac_ctx matches 1..6 run scoreboard players remove #value ac_ctx 12
