# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function wenfei:player/mark_audience
execute unless score @s wq_state matches 3 as @a[tag=wq.audience] run function wenfei:ui/open
execute if score @s wq_state matches 3 as @a[tag=wq.audience,scores={wq_guess=1}] run function wenfei:ui/open
tag @a[tag=wq.audience] remove wq.audience
