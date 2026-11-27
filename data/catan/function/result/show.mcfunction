scoreboard players operation #result_table ca_ctx = @s ct_id
execute as @e[type=minecraft:text_display,tag=ca.result] if score @s ct_id = #result_table ca_ctx run kill @s
execute unless score @s ct_game matches 21 run return 0
execute unless data entity @s data.catan{phase:11} run return 0
scoreboard players set #result_y ca_ctx 180
execute store result score #result_n ca_ctx run data get entity @s data.catan.n
execute if score #result_n ca_ctx matches 4..4 run function catan:result/player {side:4}
execute if score #result_n ca_ctx matches 3..4 run function catan:result/player {side:3}
execute if score #result_n ca_ctx matches 2..4 run function catan:result/player {side:2}
execute if score #result_n ca_ctx matches 1..4 run function catan:result/player {side:1}
data modify storage catan:result line set value {text:"卡坦岛 · 终局战绩",color:"gold",bold:true}
function catan:result/emit
