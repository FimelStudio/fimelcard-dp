scoreboard players set #can_operate dd_ctx 0
execute if score @s dd_seat = @e[tag=dd.current,limit=1] dd_turn run scoreboard players set #can_operate dd_ctx 1
execute if entity @e[tag=dd.current,scores={dd_state=2,dd_bidmode=2},limit=1] run scoreboard players set #can_operate dd_ctx 1
