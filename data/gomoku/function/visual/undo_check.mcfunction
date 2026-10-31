$execute if entity @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=$(sq),gm_piece=0},limit=1] run function gomoku:visual/retract
