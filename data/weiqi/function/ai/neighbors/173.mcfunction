execute if score @e[tag=go.board,scores={go_sq=172},limit=1] go_piece = @s go_turn run scoreboard players add #ai_own go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=172},limit=1] go_piece matches 0 run scoreboard players add #ai_empty go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=172},limit=1] go_piece matches -1..1 unless score @e[tag=go.board,scores={go_sq=172},limit=1] go_piece matches 0 unless score @e[tag=go.board,scores={go_sq=172},limit=1] go_piece = @s go_turn run scoreboard players add #ai_opp go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=174},limit=1] go_piece = @s go_turn run scoreboard players add #ai_own go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=174},limit=1] go_piece matches 0 run scoreboard players add #ai_empty go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=174},limit=1] go_piece matches -1..1 unless score @e[tag=go.board,scores={go_sq=174},limit=1] go_piece matches 0 unless score @e[tag=go.board,scores={go_sq=174},limit=1] go_piece = @s go_turn run scoreboard players add #ai_opp go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=154},limit=1] go_piece = @s go_turn run scoreboard players add #ai_own go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=154},limit=1] go_piece matches 0 run scoreboard players add #ai_empty go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=154},limit=1] go_piece matches -1..1 unless score @e[tag=go.board,scores={go_sq=154},limit=1] go_piece matches 0 unless score @e[tag=go.board,scores={go_sq=154},limit=1] go_piece = @s go_turn run scoreboard players add #ai_opp go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=192},limit=1] go_piece = @s go_turn run scoreboard players add #ai_own go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=192},limit=1] go_piece matches 0 run scoreboard players add #ai_empty go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=192},limit=1] go_piece matches -1..1 unless score @e[tag=go.board,scores={go_sq=192},limit=1] go_piece matches 0 unless score @e[tag=go.board,scores={go_sq=192},limit=1] go_piece = @s go_turn run scoreboard players add #ai_opp go_ctx 1
