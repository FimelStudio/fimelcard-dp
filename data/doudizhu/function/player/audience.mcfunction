scoreboard players operation #ctx dd_ctx = @s dd_id
tag @a[tag=dd.audience] remove dd.audience
execute as @a[tag=dd.player] if score @s dd_id = #ctx dd_ctx run tag @s add dd.audience
scoreboard players set #out dd_ctx 0
execute if score @s dd_humans matches 4 run scoreboard players operation #out dd_ctx = @s dd_out
tag @e[tag=dd.actors] remove dd.actors
execute as @e[tag=dd.actor] if score @s dd_id = #ctx dd_ctx unless score @s dd_seat = #out dd_ctx run tag @s add dd.actors
