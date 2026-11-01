scoreboard players operation #ai_to go_ctx = #to go_ctx
scoreboard players operation #ai_score go_ctx = #captured go_ctx
scoreboard players set #ai_hundred go_ctx 100
scoreboard players operation #ai_score go_ctx *= #ai_hundred go_ctx
scoreboard players operation #ai_lib go_ctx = #liberties go_ctx
execute if score #ai_lib go_ctx matches 7.. run scoreboard players set #ai_lib go_ctx 6
scoreboard players operation #ai_score go_ctx += #ai_lib go_ctx
execute if score #liberties go_ctx matches 1 run scoreboard players remove #ai_score go_ctx 70
scoreboard players operation #ai_file go_ctx = @e[tag=go.ai_candidate,limit=1] go_file
scoreboard players operation #ai_rank go_ctx = @e[tag=go.ai_candidate,limit=1] go_rank
scoreboard players operation #ai_edge go_ctx = @s go_size
scoreboard players remove #ai_edge go_ctx 1
scoreboard players operation #ai_farfile go_ctx = #ai_edge go_ctx
scoreboard players operation #ai_farfile go_ctx -= #ai_file go_ctx
scoreboard players operation #ai_farrank go_ctx = #ai_edge go_ctx
scoreboard players operation #ai_farrank go_ctx -= #ai_rank go_ctx
scoreboard players operation #ai_dist go_ctx = #ai_file go_ctx
scoreboard players operation #ai_dist go_ctx < #ai_rank go_ctx
scoreboard players operation #ai_dist go_ctx < #ai_farfile go_ctx
scoreboard players operation #ai_dist go_ctx < #ai_farrank go_ctx
execute if score @s go_level matches 2.. if score #ai_dist go_ctx matches 2..3 run scoreboard players add #ai_score go_ctx 12
execute if score @s go_level matches 2.. if score #ai_dist go_ctx matches 0 run scoreboard players remove #ai_score go_ctx 9
scoreboard players set #ai_own go_ctx 0
scoreboard players set #ai_opp go_ctx 0
scoreboard players set #ai_empty go_ctx 0
execute store result storage weiqi:runtime ai.to int 1 run scoreboard players get #ai_to go_ctx
function weiqi:ai/neighbors with storage weiqi:runtime ai
execute if score @s go_level matches 2.. if score #ai_own go_ctx matches 1..2 run scoreboard players add #ai_score go_ctx 5
execute if score @s go_level matches 3 if score #ai_opp go_ctx matches 1.. run scoreboard players add #ai_score go_ctx 4
# 四周全是己方棋子/边界的点，在没有提子时通常是眼，不主动填。
execute if score @s go_level matches 2.. if score #ai_empty go_ctx matches 0 if score #ai_opp go_ctx matches 0 if score #captured go_ctx matches 0 run scoreboard players remove #ai_score go_ctx 300
execute store result score #ai_noise go_ctx run random value 0..5
scoreboard players operation #ai_score go_ctx += #ai_noise go_ctx
execute if score #ai_score go_ctx > @s go_aiscore run function weiqi:ai/store_best
