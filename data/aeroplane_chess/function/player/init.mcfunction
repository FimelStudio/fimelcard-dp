tag @s add ac.player
scoreboard players operation @s ac_table = @s ct_id
scoreboard players operation @s ac_seat = @s ct_seat
scoreboard players set @s ac_seen -1
function aeroplane_chess:player/seat_color
execute if score @e[tag=ac.current,limit=1] ac_assign matches 1 run scoreboard players operation #wanted ac_ctx = @e[tag=ac.sides,scores={ac_active=0},sort=random,limit=1] ac_color
scoreboard players set #claimed ac_ctx 0
function aeroplane_chess:player/claim
execute if score #claimed ac_ctx matches 0 run function aeroplane_chess:player/next_claim
execute if score #claimed ac_ctx matches 0 run function aeroplane_chess:player/next_claim
execute if score #claimed ac_ctx matches 0 run function aeroplane_chess:player/next_claim
scoreboard players operation @s ac_color = #wanted ac_ctx
scoreboard players add @e[tag=ac.current,limit=1] ac_players 1
