$execute unless entity @e[tag=go.board,scores={go_sq=$(sq)},limit=1] run return 0
$execute if score @e[tag=go.board,scores={go_sq=$(sq)},limit=1] go_piece matches 0 run return 0
execute as @e[tag=go.board] run scoreboard players operation @s go_eff = @s go_piece
scoreboard players operation #seed go_ctx = #to go_ctx
$scoreboard players operation #color go_ctx = @e[tag=go.board,scores={go_sq=$(sq)},limit=1] go_piece
scoreboard players set #newdead go_ctx 1
$execute if score @e[tag=go.board,scores={go_sq=$(sq)},limit=1] go_dead matches 1 run scoreboard players set #newdead go_ctx 0
function weiqi:engine/group/start
scoreboard players operation @e[tag=go.board,tag=go.group] go_dead = #newdead go_ctx
scoreboard players operation #changed go_ctx = #count go_ctx
scoreboard players set #ok go_ctx 1
function weiqi:engine/group/clear
