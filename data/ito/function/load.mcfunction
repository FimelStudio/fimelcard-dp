scoreboard objectives add it_input dummy
scoreboard objectives add it_settings trigger
scoreboard objectives add it_settable dummy
scoreboard objectives add it_ctx dummy
scoreboard objectives add it_state dummy
scoreboard objectives add it_round dummy
scoreboard objectives add it_life dummy
scoreboard objectives add it_timer dummy
scoreboard objectives add it_pulse dummy
scoreboard objectives add it_epoch dummy
scoreboard objectives add it_seat dummy
scoreboard objectives add it_table dummy
scoreboard objectives add it_order dummy
scoreboard objectives add it_count dummy
scoreboard objectives add it_number dummy
scoreboard objectives add it_owner dummy
scoreboard objectives add it_slot dummy
scoreboard objectives add it_used dummy
scoreboard objectives add it_vote dummy
scoreboard objectives add it_window dummy
scoreboard objectives add it_win_epoch dummy
scoreboard objectives add it_form dummy
scoreboard objectives add it_panel dummy
scoreboard objectives add it_previous dummy
scoreboard objectives add it_setnonce dummy
scoreboard objectives add it_action trigger
scoreboard players add #epoch it_ctx 100
scoreboard players set #hundred it_ctx 100
scoreboard players set #four it_ctx 4
function ito:themes/load
execute in minecraft:overworld as @e[type=minecraft:marker,tag=it.controller] at @s run function ito:system/reload
execute in minecraft:the_nether as @e[type=minecraft:marker,tag=it.controller] at @s run function ito:system/reload
execute in minecraft:the_end as @e[type=minecraft:marker,tag=it.controller] at @s run function ito:system/reload
