scoreboard players set #old_rquiet xq_ctx -1
scoreboard players set #old_bquiet xq_ctx -1
$execute store result score #old_rquiet xq_ctx run data get entity @s data.xiangqi.history[{key:"$(key)"}].rquiet
$execute store result score #old_bquiet xq_ctx run data get entity @s data.xiangqi.history[{key:"$(key)"}].bquiet
execute if score #old_rquiet xq_ctx = #rquiet xq_ctx unless score #old_bquiet xq_ctx = #bquiet xq_ctx run data modify entity @s data.xiangqi.history[0].loser set value 1
execute if score #old_bquiet xq_ctx = #bquiet xq_ctx unless score #old_rquiet xq_ctx = #rquiet xq_ctx run data modify entity @s data.xiangqi.history[0].loser set value -1
