# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if entity @e[tag=ll.current,scores={ll_phase=1},limit=1] if score @s ll_seat = @e[tag=ll.current,limit=1] ll_turn run scoreboard players set #ui_active ll_ctx 1
execute if entity @e[tag=ll.current,scores={ll_phase=2..5},limit=1] if score @s ll_seat = @e[tag=ll.current,limit=1] ll_actor run scoreboard players set #ui_active ll_ctx 1
