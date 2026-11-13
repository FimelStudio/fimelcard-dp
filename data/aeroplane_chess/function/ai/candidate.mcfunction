$scoreboard players set #plane ac_ctx $(plane)
function aeroplane_chess:engine/plan
execute unless score #legal ac_ctx matches 1 run return 0
scoreboard players operation #value ac_ctx = #dest ac_ctx
execute if score #dest ac_ctx matches 0 run scoreboard players add #value ac_ctx 35
execute if score #dest ac_ctx matches 57 run scoreboard players add #value ac_ctx 1000
execute if score #dest ac_ctx matches 1..51 run function aeroplane_chess:ai/captures
execute if score #dest ac_ctx matches 1..51 run function aeroplane_chess:ai/risk
execute if score #value ac_ctx > #best ac_ctx run scoreboard players operation #bestplane ac_ctx = #plane ac_ctx
execute if score #value ac_ctx > #best ac_ctx run scoreboard players operation #best ac_ctx = #value ac_ctx
