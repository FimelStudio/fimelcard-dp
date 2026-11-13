tag @e[tag=ll.legal] remove ll.legal
execute as @e[tag=ll.board,scores={ll_alive=1,ll_protect=0}] unless score @s ll_seat = #actor ll_ctx run tag @s add ll.legal
execute if score #card ll_ctx matches 5 as @e[tag=ll.board,scores={ll_alive=1,ll_protect=0}] run tag @s add ll.legal
execute unless entity @e[tag=ll.legal] run return 0
execute if score @s ll_timeout matches 1 run return 0
execute if score @s ll_target_mode matches 1 unless score @s ll_exact matches 1..8 run return run function love_letter:targeting/request
execute unless score @s ll_exact matches 1..8 run function love_letter:targeting/resolve
execute unless score @s ll_exact matches 1..8 if score #blocked ll_ctx matches 1 run scoreboard players set #error ll_ctx 4
execute if score @s ll_exact matches 1..8 run scoreboard players operation #aim ll_ctx = @s ll_exact
execute as @e[tag=ll.legal] if score @s ll_seat = #aim ll_ctx run scoreboard players operation #pre_target ll_ctx = @s ll_seat
execute if score #aim ll_ctx matches 1..8 unless score #pre_target ll_ctx matches 1..8 run scoreboard players set #error ll_ctx 4
execute unless score #error ll_ctx matches 4 if score #aim ll_ctx matches 0 if score #card ll_ctx matches 5 run scoreboard players operation #pre_target ll_ctx = #actor ll_ctx
execute if score #pre_target ll_ctx matches 0 unless score #error ll_ctx matches 4 run scoreboard players set #error ll_ctx 3
