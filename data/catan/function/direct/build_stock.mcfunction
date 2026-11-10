scoreboard players set #pieces ca_ctx 0
execute if score @s ca_mode matches 2 store result score #pieces ca_ctx run data get storage catan:ui hand.settlements_left
execute if score @s ca_mode matches 3 store result score #pieces ca_ctx run data get storage catan:ui hand.roads_left
execute if score @s ca_mode matches 4 store result score #pieces ca_ctx run data get storage catan:ui hand.cities_left
execute unless score #pieces ca_ctx matches 1.. run scoreboard players set #direct_ready ca_ctx 0
execute unless score #direct_ready ca_ctx matches 1 run function catan:hud/notice {"text":{"text":"该类建筑棋子已经用完，无法继续建造。","color":"red"}}
