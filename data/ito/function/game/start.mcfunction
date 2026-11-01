scoreboard players set @s ct_start 0
execute if score @s ct_state matches 1 run return fail
execute unless score @s ct_joined matches 2..8 run return run function ito:game/bad_start
execute if score @s ct_joined > @s ct_capacity run return run function ito:game/bad_start
scoreboard players operation #table it_ctx = @s ct_id
tag @a[tag=it.joining] remove it.joining
execute as @a[tag=ct.player] if score @s ct_id = #table it_ctx run tag @s add it.joining
scoreboard players set #online it_ctx 0
scoreboard players set #occupied it_ctx 0
execute as @a[tag=it.joining] run scoreboard players add #online it_ctx 1
execute unless score #online it_ctx = @s ct_joined run return run function ito:game/bad_start
execute as @a[tag=it.joining] if items entity @s hotbar.0 * run scoreboard players set #occupied it_ctx 1
execute as @a[tag=it.joining] if items entity @s hotbar.1 * run scoreboard players set #occupied it_ctx 1
execute as @a[tag=it.joining] if items entity @s hotbar.2 * run scoreboard players set #occupied it_ctx 1
execute as @a[tag=it.joining] if items entity @s hotbar.8 * run scoreboard players set #occupied it_ctx 1
execute if score #occupied it_ctx matches 1 run return run function ito:game/bad_slots
function ito:game/remove
tag @s add it.controller
scoreboard players operation @s it_count = #online it_ctx
scoreboard players set @s it_round 1
scoreboard players set @s it_life 3
scoreboard players set @s it_pulse 0
scoreboard players set @s it_timer 0
scoreboard players set #join_order it_ctx 0
execute as @a[tag=it.joining,scores={ct_seat=1}] run function ito:player/join
execute as @a[tag=it.joining,scores={ct_seat=2}] run function ito:player/join
execute as @a[tag=it.joining,scores={ct_seat=3}] run function ito:player/join
execute as @a[tag=it.joining,scores={ct_seat=4}] run function ito:player/join
execute as @a[tag=it.joining,scores={ct_seat=5}] run function ito:player/join
execute as @a[tag=it.joining,scores={ct_seat=6}] run function ito:player/join
execute as @a[tag=it.joining,scores={ct_seat=7}] run function ito:player/join
execute as @a[tag=it.joining,scores={ct_seat=8}] run function ito:player/join
tag @a[tag=it.joining] remove it.joining
function ito:system/context
scoreboard players set @s ct_start 1
function ito:round/begin
function ito:log {text:"蛛丝开局，三关1/2/3张，共享3点生命"}
