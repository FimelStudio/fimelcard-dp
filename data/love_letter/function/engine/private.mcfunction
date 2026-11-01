data modify entity @s data.ll_private set value {kind:"",seat:0,target:0,actor_card:-1,target_card:-1}
execute store result entity @s data.ll_private.seat int 1 run scoreboard players get @s ll_actor
execute store result entity @s data.ll_private.target int 1 run scoreboard players get @s ll_target
execute store result entity @s data.ll_private.actor_card int 1 run scoreboard players get @e[tag=ll.engine_actor,limit=1] ll_hand
execute store result entity @s data.ll_private.target_card int 1 run scoreboard players get @e[tag=ll.engine_target,limit=1] ll_hand
