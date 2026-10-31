scoreboard players operation #landing ac_ctx = #color ac_ctx
scoreboard players operation #landing ac_ctx *= #thirteen ac_ctx
scoreboard players operation #landing ac_ctx += #dest ac_ctx
scoreboard players remove #landing ac_ctx 1
scoreboard players operation #landing ac_ctx %= #fiftytwo ac_ctx
execute as @e[tag=ac.board,scores={ac_pos=1..51}] unless score @s ac_color = #color ac_ctx run function aeroplane_chess:ai/capture_value
