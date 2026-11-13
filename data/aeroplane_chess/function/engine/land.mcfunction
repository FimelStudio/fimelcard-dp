# 仅 land=1 的实际落点撞机，途经格绝不撞机；同格全部敌机一起返航。
function aeroplane_chess:system/context
execute unless score @s ac_topos matches 1..51 run return 0
scoreboard players operation #landing ac_ctx = @s ac_turn
scoreboard players operation #landing ac_ctx *= #thirteen ac_ctx
scoreboard players operation #landing ac_ctx += @s ac_topos
scoreboard players remove #landing ac_ctx 1
scoreboard players operation #landing ac_ctx %= #fiftytwo ac_ctx
scoreboard players operation #color ac_ctx = @s ac_turn
scoreboard players set #captured ac_ctx 0
execute as @e[tag=ac.board,scores={ac_pos=1..51}] unless score @s ac_color = #color ac_ctx run function aeroplane_chess:engine/check_capture
execute if score #captured ac_ctx matches 1.. run function aeroplane_chess:visual/capture
execute if score #captured ac_ctx matches 1.. run function aeroplane_chess:sound/capture
