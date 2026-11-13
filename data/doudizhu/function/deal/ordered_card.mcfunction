scoreboard players operation #recipient dd_ctx = @s dd_seat
execute as @e[tag=dd.pool,scores={dd_owner=0}] if score @s dd_deckpos = #dealpos dd_ctx run scoreboard players operation @s dd_owner = #recipient dd_ctx
scoreboard players add #dealpos dd_ctx 1
