tag @s remove go.front
tag @s add go.group
scoreboard players add #count go_ctx 1
execute store result storage weiqi:runtime node.sq int 1 run scoreboard players get @s go_sq
function weiqi:engine/group/dispatch with storage weiqi:runtime node
