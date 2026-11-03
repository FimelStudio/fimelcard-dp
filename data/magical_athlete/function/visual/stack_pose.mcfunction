scoreboard players set #stack_count ma_ctx 0
scoreboard players set #stack_rank ma_ctx 0
$scoreboard players set #stack_index ma_ctx $(index)
$scoreboard players set #stack_pos ma_ctx $(pos)
execute store result score #probe_pos ma_ctx run data get entity @s data.magical_athlete.racers[0].pos
execute store result score #probe_status ma_ctx run data get entity @s data.magical_athlete.racers[0].status
execute if score #probe_pos ma_ctx = #stack_pos ma_ctx if score #probe_status ma_ctx matches 0..1 run scoreboard players add #stack_count ma_ctx 1
execute if score #probe_pos ma_ctx = #stack_pos ma_ctx if score #probe_status ma_ctx matches 0..1 if score #stack_index ma_ctx matches 1.. run scoreboard players add #stack_rank ma_ctx 1
execute store result score #probe_pos ma_ctx run data get entity @s data.magical_athlete.racers[1].pos
execute store result score #probe_status ma_ctx run data get entity @s data.magical_athlete.racers[1].status
execute if score #probe_pos ma_ctx = #stack_pos ma_ctx if score #probe_status ma_ctx matches 0..1 run scoreboard players add #stack_count ma_ctx 1
execute if score #probe_pos ma_ctx = #stack_pos ma_ctx if score #probe_status ma_ctx matches 0..1 if score #stack_index ma_ctx matches 2.. run scoreboard players add #stack_rank ma_ctx 1
execute store result score #probe_pos ma_ctx run data get entity @s data.magical_athlete.racers[2].pos
execute store result score #probe_status ma_ctx run data get entity @s data.magical_athlete.racers[2].status
execute if score #probe_pos ma_ctx = #stack_pos ma_ctx if score #probe_status ma_ctx matches 0..1 run scoreboard players add #stack_count ma_ctx 1
execute if score #probe_pos ma_ctx = #stack_pos ma_ctx if score #probe_status ma_ctx matches 0..1 if score #stack_index ma_ctx matches 3.. run scoreboard players add #stack_rank ma_ctx 1
execute store result score #probe_pos ma_ctx run data get entity @s data.magical_athlete.racers[3].pos
execute store result score #probe_status ma_ctx run data get entity @s data.magical_athlete.racers[3].status
execute if score #probe_pos ma_ctx = #stack_pos ma_ctx if score #probe_status ma_ctx matches 0..1 run scoreboard players add #stack_count ma_ctx 1
execute if score #probe_pos ma_ctx = #stack_pos ma_ctx if score #probe_status ma_ctx matches 0..1 if score #stack_index ma_ctx matches 4.. run scoreboard players add #stack_rank ma_ctx 1
execute store result score #probe_pos ma_ctx run data get entity @s data.magical_athlete.racers[4].pos
execute store result score #probe_status ma_ctx run data get entity @s data.magical_athlete.racers[4].status
execute if score #probe_pos ma_ctx = #stack_pos ma_ctx if score #probe_status ma_ctx matches 0..1 run scoreboard players add #stack_count ma_ctx 1
execute if score #probe_pos ma_ctx = #stack_pos ma_ctx if score #probe_status ma_ctx matches 0..1 if score #stack_index ma_ctx matches 5.. run scoreboard players add #stack_rank ma_ctx 1
execute store result score #probe_pos ma_ctx run data get entity @s data.magical_athlete.racers[5].pos
execute store result score #probe_status ma_ctx run data get entity @s data.magical_athlete.racers[5].status
execute if score #probe_pos ma_ctx = #stack_pos ma_ctx if score #probe_status ma_ctx matches 0..1 run scoreboard players add #stack_count ma_ctx 1
execute if score #probe_pos ma_ctx = #stack_pos ma_ctx if score #probe_status ma_ctx matches 0..1 if score #stack_index ma_ctx matches 6.. run scoreboard players add #stack_rank ma_ctx 1
execute if score #stack_count ma_ctx matches 0 run return 0
execute store result storage magical_athlete:visual stack.count int 1 run scoreboard players get #stack_count ma_ctx
execute store result storage magical_athlete:visual stack.rank int 1 run scoreboard players get #stack_rank ma_ctx
function magical_athlete:visual/stack_get with storage magical_athlete:visual stack
