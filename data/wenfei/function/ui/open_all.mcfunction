function wenfei:player/mark_audience
execute unless score @s wq_state matches 3 as @a[tag=wq.audience] run function wenfei:ui/open
execute if score @s wq_state matches 3 as @a[tag=wq.audience,scores={wq_guess=1}] run function wenfei:ui/open
tag @a[tag=wq.audience] remove wq.audience
