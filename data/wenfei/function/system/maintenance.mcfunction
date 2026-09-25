function wenfei:player/mark_audience
scoreboard players set #online wq_ctx 0
execute as @a[tag=wq.audience] if score @s ct_id = #ctx wq_ctx run scoreboard players add #online wq_ctx 1
execute unless score #online wq_ctx = @s wq_players run return run function wenfei:game/player_left
tag @a[tag=wq.audience] remove wq.audience
