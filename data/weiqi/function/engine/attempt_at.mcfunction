$execute unless entity @e[tag=go.board,scores={go_sq=$(sq)},limit=1] run return 0
scoreboard players set #error go_ctx 2
$execute unless score @e[tag=go.board,scores={go_sq=$(sq)},limit=1] go_piece matches 0 run return 0
execute as @e[tag=go.board] run scoreboard players operation @s go_backup = @s go_piece
execute as @e[tag=go.board] run scoreboard players operation @s go_eff = @s go_piece
data modify storage weiqi:runtime captured set value []
$scoreboard players operation @e[tag=go.board,scores={go_sq=$(sq)},limit=1] go_piece = #side go_ctx
$scoreboard players operation @e[tag=go.board,scores={go_sq=$(sq)},limit=1] go_eff = #side go_ctx
$function weiqi:engine/capture/at_$(sq)
scoreboard players operation #seed go_ctx = #to go_ctx
scoreboard players operation #color go_ctx = #side go_ctx
function weiqi:engine/group/start
scoreboard players operation #liberties go_ctx = #libs go_ctx
scoreboard players set #error go_ctx 3
execute if score #libs go_ctx matches 1.. run scoreboard players set #legal go_ctx 1
execute if score #legal go_ctx matches 1 run function weiqi:engine/encode
execute if score #legal go_ctx matches 1 run function weiqi:engine/superko/filter with storage weiqi:runtime position
execute if score #legal go_ctx matches 1 if score #commit go_ctx matches 1 run function weiqi:engine/commit
execute if score #legal go_ctx matches 0 run function weiqi:engine/rollback
execute if score #commit go_ctx matches 0 run function weiqi:engine/rollback
execute if score #legal go_ctx matches 1 run scoreboard players set #error go_ctx 0
function weiqi:engine/group/clear
