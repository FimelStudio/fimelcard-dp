dialog clear @s
scoreboard players operation #ctx wq_ctx = @s wq_id
execute unless entity @s[tag=wq.player] run return 0
execute unless score @s ct_id = @s wq_id run return 0
tag @e[tag=wq.current] remove wq.current
tag @a[tag=wq.actor] remove wq.actor
tag @s add wq.actor
execute as @e[type=minecraft:marker,tag=wq.controller,scores={wq_state=1..4}] if score @s wq_id = #ctx wq_ctx run tag @s add wq.current
scoreboard players operation @s wq_ui_table = @s wq_id
scoreboard players set @s wq_action 0
scoreboard players enable @s wq_action
execute as @e[tag=wq.current,limit=1] run function wenfei:ui/build
tag @a[tag=wq.actor] remove wq.actor
tag @e[tag=wq.current] remove wq.current
