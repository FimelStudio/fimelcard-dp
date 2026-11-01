execute if entity @e[tag=ll.current,scores={ll_phase=1},limit=1] if score @s ll_seat = @e[tag=ll.current,limit=1] ll_turn run scoreboard players set #ui_active ll_ctx 1
execute if entity @e[tag=ll.current,scores={ll_phase=2..5},limit=1] if score @s ll_seat = @e[tag=ll.current,limit=1] ll_actor run scoreboard players set #ui_active ll_ctx 1
