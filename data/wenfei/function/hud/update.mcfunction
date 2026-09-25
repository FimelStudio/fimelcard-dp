function wenfei:player/mark_audience
execute store result storage wenfei:io board.round int 1 run scoreboard players get @s wq_round
execute store result storage wenfei:io board.total int 1 run scoreboard players get @s wq_total
function wenfei:hud/header with storage wenfei:io board
execute if score @s wq_state matches 1 run data modify storage wenfei:io board.text.extra append value {text:"选择类别\n",color:"yellow"}
execute if score @s wq_state matches 2 run data modify storage wenfei:io board.text.extra append value {text:"秘密回答\n",color:"yellow"}
execute if score @s wq_state matches 3 run data modify storage wenfei:io board.text.extra append value {text:"逐张评分\n",color:"yellow"}
execute if score @s wq_state matches 4 run data modify storage wenfei:io board.text.extra append value {text:"本轮结算\n",color:"yellow"}
execute as @a[tag=wq.audience] run function wenfei:hud/player
execute as @e[tag=wq.board] if score @s wq_id = #ctx wq_ctx run data modify entity @s text set from storage wenfei:io board.text
