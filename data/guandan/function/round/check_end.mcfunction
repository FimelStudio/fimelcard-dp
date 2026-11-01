execute unless score @s gd_state matches 3 run return 0
scoreboard players set #firstteam gd_ctx -1
execute as @e[tag=gd.board,scores={gd_rank=1}] run scoreboard players operation #firstteam gd_ctx = @s gd_team
scoreboard players set #double gd_ctx 0
execute as @e[tag=gd.board,scores={gd_rank=2}] if score @s gd_team = #firstteam gd_ctx run scoreboard players set #double gd_ctx 1
execute if score #double gd_ctx matches 1 run return run function guandan:round/over
execute if score @s gd_done matches 3.. run function guandan:round/over
