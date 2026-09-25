scoreboard players add @s wq_turn 1
execute if score @s wq_turn matches 5.. run scoreboard players set @s wq_turn 1
function wenfei:player/mark_audience
scoreboard players operation #turn wq_ctx = @s wq_turn
scoreboard players set #found wq_ctx 0
execute as @a[tag=wq.audience] if score @s wq_seat = #turn wq_ctx run scoreboard players set #found wq_ctx 1
execute if score #found wq_ctx matches 0 run return run function wenfei:round/next
function wenfei:round/begin
