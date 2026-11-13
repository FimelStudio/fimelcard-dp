execute if score @e[tag=go.board,scores={go_sq=40},limit=1] go_piece = @s go_turn run scoreboard players add #ai_own go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=40},limit=1] go_piece matches 0 run scoreboard players add #ai_empty go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=40},limit=1] go_piece matches -1..1 unless score @e[tag=go.board,scores={go_sq=40},limit=1] go_piece matches 0 unless score @e[tag=go.board,scores={go_sq=40},limit=1] go_piece = @s go_turn run scoreboard players add #ai_opp go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=42},limit=1] go_piece = @s go_turn run scoreboard players add #ai_own go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=42},limit=1] go_piece matches 0 run scoreboard players add #ai_empty go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=42},limit=1] go_piece matches -1..1 unless score @e[tag=go.board,scores={go_sq=42},limit=1] go_piece matches 0 unless score @e[tag=go.board,scores={go_sq=42},limit=1] go_piece = @s go_turn run scoreboard players add #ai_opp go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=22},limit=1] go_piece = @s go_turn run scoreboard players add #ai_own go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=22},limit=1] go_piece matches 0 run scoreboard players add #ai_empty go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=22},limit=1] go_piece matches -1..1 unless score @e[tag=go.board,scores={go_sq=22},limit=1] go_piece matches 0 unless score @e[tag=go.board,scores={go_sq=22},limit=1] go_piece = @s go_turn run scoreboard players add #ai_opp go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=60},limit=1] go_piece = @s go_turn run scoreboard players add #ai_own go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=60},limit=1] go_piece matches 0 run scoreboard players add #ai_empty go_ctx 1
execute if score @e[tag=go.board,scores={go_sq=60},limit=1] go_piece matches -1..1 unless score @e[tag=go.board,scores={go_sq=60},limit=1] go_piece matches 0 unless score @e[tag=go.board,scores={go_sq=60},limit=1] go_piece = @s go_turn run scoreboard players add #ai_opp go_ctx 1
