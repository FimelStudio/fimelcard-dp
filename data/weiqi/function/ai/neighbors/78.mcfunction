execute if score @e[tag=go.board,scores={go_sq=77},limit=1] go_piece = @s go_turn run scoreboard players add #ai_own go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=77},limit=1] go_piece matches 0 run scoreboard players add #ai_empty go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=77},limit=1] go_piece matches -1..1 unless score @e[tag=go.board,scores={go_sq=77},limit=1] go_piece matches 0 unless score @e[tag=go.board,scores={go_sq=77},limit=1] go_piece = @s go_turn run scoreboard players add #ai_opp go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=79},limit=1] go_piece = @s go_turn run scoreboard players add #ai_own go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=79},limit=1] go_piece matches 0 run scoreboard players add #ai_empty go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=79},limit=1] go_piece matches -1..1 unless score @e[tag=go.board,scores={go_sq=79},limit=1] go_piece matches 0 unless score @e[tag=go.board,scores={go_sq=79},limit=1] go_piece = @s go_turn run scoreboard players add #ai_opp go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=59},limit=1] go_piece = @s go_turn run scoreboard players add #ai_own go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=59},limit=1] go_piece matches 0 run scoreboard players add #ai_empty go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=59},limit=1] go_piece matches -1..1 unless score @e[tag=go.board,scores={go_sq=59},limit=1] go_piece matches 0 unless score @e[tag=go.board,scores={go_sq=59},limit=1] go_piece = @s go_turn run scoreboard players add #ai_opp go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=97},limit=1] go_piece = @s go_turn run scoreboard players add #ai_own go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=97},limit=1] go_piece matches 0 run scoreboard players add #ai_empty go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=97},limit=1] go_piece matches -1..1 unless score @e[tag=go.board,scores={go_sq=97},limit=1] go_piece matches 0 unless score @e[tag=go.board,scores={go_sq=97},limit=1] go_piece = @s go_turn run scoreboard players add #ai_opp go_ctx 1
