execute if score @s wq_state matches 1 if entity @a[tag=wq.actor,scores={wq_guess=1}] if score #choice wq_ctx matches 1..6 run return run function wenfei:round/category
execute as @a[tag=wq.actor,limit=1] run function wenfei:ui/open
