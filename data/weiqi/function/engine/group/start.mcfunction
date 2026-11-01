function weiqi:engine/group/clear
scoreboard players set #border_black go_ctx 0
scoreboard players set #border_white go_ctx 0
scoreboard players set #count go_ctx 0
execute store result storage weiqi:runtime seed.sq int 1 run scoreboard players get #seed go_ctx
function weiqi:engine/group/seed with storage weiqi:runtime seed
function weiqi:engine/group/loop
execute store result score #libs go_ctx if entity @e[tag=go.board,tag=go.lib]
