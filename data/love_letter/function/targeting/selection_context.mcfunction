scoreboard players operation #actor ll_ctx = @s ll_select_actor
scoreboard players set #card ll_ctx -1
execute if score @s ll_select_slot matches 0 as @e[tag=ll.board] if score @s ll_seat = #actor ll_ctx run scoreboard players operation #card ll_ctx = @s ll_hand
execute if score @e[tag=ll.current,limit=1] ll_select_slot matches 1 as @e[tag=ll.board] if score @s ll_seat = #actor ll_ctx run scoreboard players operation #card ll_ctx = @s ll_extra
tag @e[tag=ll.legal] remove ll.legal
execute as @e[tag=ll.board,scores={ll_alive=1,ll_protect=0}] unless score @s ll_seat = #actor ll_ctx run tag @s add ll.legal
execute if score #card ll_ctx matches 5 as @e[tag=ll.board,scores={ll_alive=1,ll_protect=0}] run tag @s add ll.legal
