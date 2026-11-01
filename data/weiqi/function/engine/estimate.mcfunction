function weiqi:engine/constants
scoreboard players set @e[tag=go.board] go_bdist 999
scoreboard players set @e[tag=go.board] go_wdist 999
scoreboard players set @e[tag=go.board,scores={go_piece=1}] go_bdist 0
scoreboard players set @e[tag=go.board,scores={go_piece=-1}] go_wdist 0
scoreboard players set #est_side go_ctx 1
scoreboard players set #est_next go_ctx 1
execute as @e[tag=go.board,scores={go_bdist=0}] run function weiqi:engine/estimate/visit
scoreboard players set #est_next go_ctx 2
execute as @e[tag=go.board,scores={go_bdist=1}] run function weiqi:engine/estimate/visit
scoreboard players set #est_next go_ctx 3
execute as @e[tag=go.board,scores={go_bdist=2}] run function weiqi:engine/estimate/visit
scoreboard players set #est_next go_ctx 4
execute as @e[tag=go.board,scores={go_bdist=3}] run function weiqi:engine/estimate/visit
scoreboard players set #est_side go_ctx -1
scoreboard players set #est_next go_ctx 1
execute as @e[tag=go.board,scores={go_wdist=0}] run function weiqi:engine/estimate/visit
scoreboard players set #est_next go_ctx 2
execute as @e[tag=go.board,scores={go_wdist=1}] run function weiqi:engine/estimate/visit
scoreboard players set #est_next go_ctx 3
execute as @e[tag=go.board,scores={go_wdist=2}] run function weiqi:engine/estimate/visit
scoreboard players set #est_next go_ctx 4
execute as @e[tag=go.board,scores={go_wdist=3}] run function weiqi:engine/estimate/visit
execute as @e[tag=go.board] run function weiqi:engine/estimate/classify
execute store result score @s go_barea if entity @e[tag=go.board,scores={go_owner=1}]
execute store result score @s go_warea if entity @e[tag=go.board,scores={go_owner=-1}]
execute store result score @s go_bterrit if entity @e[tag=go.board,scores={go_piece=0,go_owner=1}]
execute store result score @s go_wterrit if entity @e[tag=go.board,scores={go_piece=0,go_owner=-1}]
execute store result score @s go_neutral if entity @e[tag=go.board,scores={go_piece=0,go_owner=0}]
scoreboard players operation @s go_bscore = @s go_barea
scoreboard players operation @s go_wscore = @s go_warea
scoreboard players operation @s go_bscore *= #two go_ctx
scoreboard players operation @s go_wscore *= #two go_ctx
scoreboard players operation @s go_wscore += @s go_komi
