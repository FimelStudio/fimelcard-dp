# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function wenfei:player/mark_audience
scoreboard players set #online wq_ctx 0
execute as @a[tag=wq.audience] if score @s ct_id = #ctx wq_ctx run scoreboard players add #online wq_ctx 1
tag @a[tag=wq.audience] remove wq.audience
