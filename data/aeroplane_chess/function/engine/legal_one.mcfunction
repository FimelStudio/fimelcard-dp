$scoreboard players set #plane ac_ctx $(plane)
function aeroplane_chess:engine/plan
execute unless score #legal ac_ctx matches 1 run return 0
scoreboard players add #available ac_ctx 1
$execute as @e[tag=ac.board,scores={ac_plane=$(plane)}] if score @s ac_color = #color ac_ctx run scoreboard players set @s ac_legal 1
