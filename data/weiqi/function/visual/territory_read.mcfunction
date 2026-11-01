scoreboard players set #v_cell_owner go_ctx 0
$execute if entity @e[tag=go.board,scores={go_sq=$(sq),go_piece=0},limit=1] run scoreboard players operation #v_cell_owner go_ctx = @e[tag=go.board,scores={go_sq=$(sq)},limit=1] go_owner
$execute if entity @e[tag=go.board,scores={go_sq=$(sq),go_dead=1},limit=1] run scoreboard players operation #v_cell_owner go_ctx = @e[tag=go.board,scores={go_sq=$(sq)},limit=1] go_owner
