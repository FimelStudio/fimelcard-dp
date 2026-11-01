execute as @e[tag=go.board,tag=go.front,limit=1] run function weiqi:engine/group/visit
execute if entity @e[tag=go.board,tag=go.front] run function weiqi:engine/group/loop
