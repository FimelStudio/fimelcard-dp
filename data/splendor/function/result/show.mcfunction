scoreboard players operation #result_table sp_ctx = @s ct_id
execute as @e[type=minecraft:text_display,tag=sp.result] if score @s ct_id = #result_table sp_ctx run kill @s
execute unless score @s ct_game matches 22 run return 0
execute unless data entity @s data.splendor{phase:4} run return 0
scoreboard players set #result_y sp_ctx 180
execute store result score #result_n sp_ctx run data get entity @s data.splendor.n
execute if score #result_n sp_ctx matches 4..4 run function splendor:result/player {side:4}
execute if score #result_n sp_ctx matches 3..4 run function splendor:result/player {side:3}
execute if score #result_n sp_ctx matches 2..4 run function splendor:result/player {side:2}
execute if score #result_n sp_ctx matches 1..4 run function splendor:result/player {side:1}
data modify storage splendor:result line set value {text:"璀璨宝石 · 终局收藏",color:"gold",bold:true}
function splendor:result/emit
