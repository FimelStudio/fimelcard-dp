function weiqi:engine/constants
scoreboard players operation #side go_ctx = @s go_turn
scoreboard players operation @s go_turn *= #minus go_ctx
scoreboard players add @s go_moves 1
scoreboard players add @s go_passes 1
data modify entity @s data.weiqi.last set value {sq:-1,side:0,captured:[],pass:1b}
execute store result entity @s data.weiqi.last.side int 1 run scoreboard players get #side go_ctx
function weiqi:engine/encode
function weiqi:engine/snapshot
scoreboard players set #legal go_ctx 1
scoreboard players set #error go_ctx 0
