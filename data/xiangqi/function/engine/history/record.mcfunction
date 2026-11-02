# 元信息和局面计数同放 history 列表，悔棋复制 history 即完整恢复重复裁判状态。
scoreboard players set #history_initial xq_ctx 0
execute unless data entity @s data.xiangqi.history[{meta:1}] run scoreboard players set #history_initial xq_ctx 1
execute if score #history_initial xq_ctx matches 1 run data modify entity @s data.xiangqi.history set value [{meta:1,rquiet:0,bquiet:0,loser:0}]
scoreboard players set #rquiet xq_ctx 0
scoreboard players set #bquiet xq_ctx 0
execute store result score #rquiet xq_ctx run data get entity @s data.xiangqi.history[0].rquiet
execute store result score #bquiet xq_ctx run data get entity @s data.xiangqi.history[0].bquiet
function xiangqi:engine/check_current
execute if score #history_initial xq_ctx matches 0 if score #side xq_ctx matches -1 if score #attacked xq_ctx matches 0 run scoreboard players add #rquiet xq_ctx 1
execute if score #history_initial xq_ctx matches 0 if score #side xq_ctx matches 1 if score #attacked xq_ctx matches 0 run scoreboard players add #bquiet xq_ctx 1
execute store result entity @s data.xiangqi.history[0].rquiet int 1 run scoreboard players get #rquiet xq_ctx
execute store result entity @s data.xiangqi.history[0].bquiet int 1 run scoreboard players get #bquiet xq_ctx
data modify storage xiangqi:engine history set value {key:"",piece:0,turn:1}
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b0 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b1 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b2 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b3 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b4 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b5 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b6 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b7 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b8 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b9 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b10 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b11 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b12 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b13 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b14 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b15 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b16 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b17 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b18 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b19 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b20 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b21 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b22 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b23 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b24 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b25 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b26 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b27 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b28 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b29 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b30 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b31 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b32 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b33 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b34 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b35 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b36 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b37 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b38 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b39 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b40 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b41 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b42 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b43 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b44 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b45 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b46 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b47 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b48 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b49 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b50 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b51 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b52 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b53 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b54 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b55 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b56 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b57 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b58 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b59 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b60 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b61 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b62 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b63 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b64 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b65 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b66 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b67 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b68 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b69 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b70 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b71 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b72 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b73 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b74 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b75 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b76 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b77 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b78 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b79 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b80 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b81 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b82 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b83 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b84 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b85 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b86 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b87 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b88 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b89 xq_ctx
function xiangqi:engine/history/append with storage xiangqi:engine history
execute store result storage xiangqi:engine history.turn int 1 run scoreboard players get #side xq_ctx
function xiangqi:engine/history/key with storage xiangqi:engine history
function xiangqi:engine/history/count with storage xiangqi:engine history
