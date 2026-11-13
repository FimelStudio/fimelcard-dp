execute if score @e[tag=go.board,scores={go_sq=134},limit=1] go_piece = @s go_turn run scoreboard players add #ai_own go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=134},limit=1] go_piece matches 0 run scoreboard players add #ai_empty go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=134},limit=1] go_piece matches -1..1 unless score @e[tag=go.board,scores={go_sq=134},limit=1] go_piece matches 0 unless score @e[tag=go.board,scores={go_sq=134},limit=1] go_piece = @s go_turn run scoreboard players add #ai_opp go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=136},limit=1] go_piece = @s go_turn run scoreboard players add #ai_own go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=136},limit=1] go_piece matches 0 run scoreboard players add #ai_empty go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=136},limit=1] go_piece matches -1..1 unless score @e[tag=go.board,scores={go_sq=136},limit=1] go_piece matches 0 unless score @e[tag=go.board,scores={go_sq=136},limit=1] go_piece = @s go_turn run scoreboard players add #ai_opp go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=116},limit=1] go_piece = @s go_turn run scoreboard players add #ai_own go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=116},limit=1] go_piece matches 0 run scoreboard players add #ai_empty go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=116},limit=1] go_piece matches -1..1 unless score @e[tag=go.board,scores={go_sq=116},limit=1] go_piece matches 0 unless score @e[tag=go.board,scores={go_sq=116},limit=1] go_piece = @s go_turn run scoreboard players add #ai_opp go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=154},limit=1] go_piece = @s go_turn run scoreboard players add #ai_own go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=154},limit=1] go_piece matches 0 run scoreboard players add #ai_empty go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=154},limit=1] go_piece matches -1..1 unless score @e[tag=go.board,scores={go_sq=154},limit=1] go_piece matches 0 unless score @e[tag=go.board,scores={go_sq=154},limit=1] go_piece = @s go_turn run scoreboard players add #ai_opp go_ctx 1
