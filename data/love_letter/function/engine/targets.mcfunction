tag @e[tag=ll.legal] remove ll.legal
scoreboard players operation #owner ll_ctx = @s ll_actor
execute as @e[tag=ll.board,scores={ll_alive=1,ll_protect=0}] unless score @s ll_seat = #owner ll_ctx run tag @s add ll.legal
execute if score @s ll_card matches 5 as @e[tag=ll.board,scores={ll_alive=1,ll_protect=0}] run tag @s add ll.legal
