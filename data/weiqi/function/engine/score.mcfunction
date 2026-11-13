# 只把已标死棋子视为空，不改真实盘面；中局估算不会擅自判死。
execute as @e[tag=go.board] run scoreboard players operation @s go_eff = @s go_piece
scoreboard players set @e[tag=go.board,scores={go_dead=1}] go_eff 0
execute as @e[tag=go.board] run scoreboard players operation @s go_owner = @s go_eff
scoreboard players set @e[tag=go.board] go_checked 0
execute store result score #black go_ctx if entity @e[tag=go.board,scores={go_eff=1}]
execute store result score #white go_ctx if entity @e[tag=go.board,scores={go_eff=-1}]
scoreboard players set #bterrit go_ctx 0
scoreboard players set #wterrit go_ctx 0
scoreboard players set #neutral go_ctx 0
execute as @e[tag=go.board,scores={go_eff=0}] unless score @s go_checked matches 1 run function weiqi:engine/score_region
scoreboard players operation @s go_bterrit = #bterrit go_ctx
scoreboard players operation @s go_wterrit = #wterrit go_ctx
scoreboard players operation @s go_neutral = #neutral go_ctx
scoreboard players operation @s go_barea = #black go_ctx
scoreboard players operation @s go_warea = #white go_ctx
scoreboard players operation @s go_barea += #bterrit go_ctx
scoreboard players operation @s go_warea += #wterrit go_ctx
scoreboard players operation @s go_bscore = @s go_barea
scoreboard players operation @s go_wscore = @s go_warea
scoreboard players operation @s go_bscore *= #two go_ctx
scoreboard players operation @s go_wscore *= #two go_ctx
scoreboard players operation @s go_wscore += @s go_komi
function weiqi:engine/group/clear
