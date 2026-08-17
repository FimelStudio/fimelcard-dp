$execute unless score @s $(alive) matches 1 run return 0
scoreboard players set #seat_online lh_ctx 0
$execute as @a[tag=lh.player,scores={lh_alive=1,lh_seat=$(seat)}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set #seat_online lh_ctx 1
$execute if score #seat_online lh_ctx matches 0 run function liars_holdem:system/offline_seat {seat:$(seat),alive:"$(alive)"}
