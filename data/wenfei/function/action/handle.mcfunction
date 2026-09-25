scoreboard players operation #submitted wq_ctx = @s wq_action
scoreboard players set @s wq_action 0
execute unless entity @s[tag=ct.player] run return 0
execute unless score @s ct_id = @s wq_id run return 0
execute unless score @s wq_ui_table = @s wq_id run return 0
scoreboard players operation #ctx wq_ctx = @s wq_id
tag @e[tag=wq.current] remove wq.current
execute as @e[type=minecraft:marker,tag=wq.controller,scores={wq_state=1..4}] if score @s wq_id = #ctx wq_ctx run tag @s add wq.current
tag @a[tag=wq.actor] remove wq.actor
tag @s add wq.actor
scoreboard players operation #epoch wq_ctx = #submitted wq_ctx
scoreboard players operation #epoch wq_ctx /= #hundred wq_ctx
scoreboard players operation #choice wq_ctx = #submitted wq_ctx
scoreboard players operation #choice wq_ctx %= #hundred wq_ctx
execute as @e[tag=wq.current,limit=1] at @s if score @s wq_epoch = #epoch wq_ctx run function wenfei:action/dispatch
tag @a[tag=wq.actor] remove wq.actor
tag @e[tag=wq.current] remove wq.current
tag @a[tag=wq.audience] remove wq.audience
