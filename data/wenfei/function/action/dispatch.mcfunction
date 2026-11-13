# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @s wq_state matches 1 if entity @a[tag=wq.actor,scores={wq_guess=1}] if score #choice wq_ctx matches 1..6 run return run function wenfei:round/category
execute as @a[tag=wq.actor,limit=1] run function wenfei:ui/open
