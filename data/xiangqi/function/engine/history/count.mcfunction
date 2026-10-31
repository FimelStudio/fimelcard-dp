scoreboard players set #rep xq_ctx 0
$execute if data entity @s data.xiangqi.history[{key:"$(key)"}] store result score #rep xq_ctx run data get entity @s data.xiangqi.history[{key:"$(key)"}].count
scoreboard players add #rep xq_ctx 1
$execute unless data entity @s data.xiangqi.history[{key:"$(key)"}] run data modify entity @s data.xiangqi.history append value {key:"$(key)",count:0,rquiet:0,bquiet:0}
$execute if score #rep xq_ctx matches 1 store result entity @s data.xiangqi.history[{key:"$(key)"}].rquiet int 1 run scoreboard players get #rquiet xq_ctx
$execute if score #rep xq_ctx matches 1 store result entity @s data.xiangqi.history[{key:"$(key)"}].bquiet int 1 run scoreboard players get #bquiet xq_ctx
$execute store result entity @s data.xiangqi.history[{key:"$(key)"}].count int 1 run scoreboard players get #rep xq_ctx
scoreboard players operation @s xq_repetition = #rep xq_ctx
data modify entity @s data.xiangqi.history[0].loser set value 0
execute if score #rep xq_ctx matches 3.. run function xiangqi:engine/history/long_check with storage xiangqi:engine history
