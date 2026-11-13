execute if score @s dc_mode matches 3 run return run function decrypto:game/check_win
scoreboard players set #white_win dc_ctx 0
scoreboard players set #black_win dc_ctx 0
execute if score @s dc_wi matches 2.. run scoreboard players set #white_win dc_ctx 1
execute if score @s dc_be matches 2.. run scoreboard players set #white_win dc_ctx 1
execute if score @s dc_bi matches 2.. run scoreboard players set #black_win dc_ctx 1
execute if score @s dc_we matches 2.. run scoreboard players set #black_win dc_ctx 1
execute if score #white_win dc_ctx matches 1 if score #black_win dc_ctx matches 1 run tellraw @a[tag=dc.audience] {text:"双方同轮达到胜利条件，本局平局。",color:"gold"}
execute if score #white_win dc_ctx matches 1 if score #black_win dc_ctx matches 1 run function cardtable:game/result/title {audience:"@a[tag=dc.audience]",title:{text:"平局",color:"yellow",bold:true},subtitle:{text:""}}
execute if score #white_win dc_ctx matches 1 if score #black_win dc_ctx matches 1 run return run function decrypto:game/finish
function decrypto:game/check_win
