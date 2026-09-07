scoreboard players set @s hb_drop_reward 0
tag @e[tag=hb.reward_reopen_drop] remove hb.reward_reopen_drop
execute at @s as @e[type=minecraft:item,distance=..3,sort=nearest,limit=1] if items entity @s contents minecraft:purple_dye[minecraft:custom_data~{hanabi:{action:'reward_reopen'}}] run tag @s add hb.reward_reopen_drop
execute unless entity @e[tag=hb.reward_reopen_drop,limit=1] run return 0
kill @e[tag=hb.reward_reopen_drop,limit=1]
tag @e[tag=hb.reward_reopen_drop] remove hb.reward_reopen_drop
execute unless entity @s[tag=hb.reward_pending] run return 0
scoreboard players operation #ctx_id hb_ctx = @s hb_id
tag @e[tag=hb.reward_reopen_controller] remove hb.reward_reopen_controller
execute as @e[type=minecraft:marker,tag=hb.controller,scores={hb_state=2,hb_reward_pending=1..}] if score @s hb_id = #ctx_id hb_ctx run tag @s add hb.reward_reopen_controller
execute unless entity @e[tag=hb.reward_reopen_controller,limit=1] run return 0
execute as @e[tag=hb.reward_reopen_controller,limit=1] at @s run function hanabi:reward/reopen
tag @e[tag=hb.reward_reopen_controller] remove hb.reward_reopen_controller
