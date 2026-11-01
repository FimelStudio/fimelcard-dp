tag @e[tag=go.ai_candidate] remove go.ai_candidate
tag @e[tag=go.board,scores={go_piece=0,go_tested=0},sort=random,limit=1] add go.ai_candidate
execute unless entity @e[tag=go.ai_candidate,limit=1] run return run function weiqi:ai/ready
scoreboard players set @e[tag=go.ai_candidate,limit=1] go_tested 1
scoreboard players operation #to go_ctx = @e[tag=go.ai_candidate,limit=1] go_sq
function weiqi:engine/check_move
execute if score #legal go_ctx matches 1 run function weiqi:ai/evaluate
scoreboard players add @s go_aiattempt 1
execute if score @s go_aiattempt >= @s go_aimoves run function weiqi:ai/ready
