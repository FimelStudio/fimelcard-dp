execute if score #found lh_ctx matches 1 run return 0
scoreboard players add @s lh_scan 1
execute if score @s lh_scan matches 5.. run scoreboard players set @s lh_scan 1
scoreboard players operation #ctx_id lh_ctx = @s lh_id
scoreboard players operation #target_seat lh_ctx = @s lh_scan
execute as @a[tag=lh.player,scores={lh_alive=1}] if score @s lh_id = #ctx_id lh_ctx if score @s lh_seat = #target_seat lh_ctx run tag @s add lh.deal_receiver
execute if entity @a[tag=lh.deal_receiver,limit=1] run scoreboard players set #found lh_ctx 1
