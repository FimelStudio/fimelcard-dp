# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players add @s wq_turn 1
execute if score @s wq_turn matches 9.. run scoreboard players set @s wq_turn 1
function wenfei:player/mark_audience
scoreboard players operation #turn wq_ctx = @s wq_turn
scoreboard players set #found wq_ctx 0
execute as @a[tag=wq.audience] if score @s wq_seat = #turn wq_ctx run scoreboard players set #found wq_ctx 1
execute if score #found wq_ctx matches 0 run return run function wenfei:round/next
function wenfei:round/begin
