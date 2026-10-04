scoreboard players set #three dd_ctx 3
scoreboard players operation #visual_index dd_ctx = @s dd_timer
scoreboard players remove #visual_index dd_ctx 12
scoreboard players operation #visual_index dd_ctx %= #three dd_ctx
scoreboard players set #visual_count dd_ctx 0
execute as @e[tag=dd.actors,scores={dd_seat=1}] run function doudizhu:deal/visual_actor
execute as @e[tag=dd.actors,scores={dd_seat=2}] run function doudizhu:deal/visual_actor
execute as @e[tag=dd.actors,scores={dd_seat=3}] run function doudizhu:deal/visual_actor
execute as @e[tag=dd.actors,scores={dd_seat=4}] run function doudizhu:deal/visual_actor
execute as @e[tag=dd.actors,scores={dd_seat=5}] run function doudizhu:deal/visual_actor
execute as @e[tag=dd.actors,scores={dd_seat=6}] run function doudizhu:deal/visual_actor
execute as @e[tag=dd.actors,scores={dd_seat=7}] run function doudizhu:deal/visual_actor
execute as @e[tag=dd.actors,scores={dd_seat=8}] run function doudizhu:deal/visual_actor
