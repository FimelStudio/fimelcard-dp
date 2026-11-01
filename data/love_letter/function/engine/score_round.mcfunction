function love_letter:system/context
execute if score @s ll_scored matches 1 run return 0
scoreboard players set @s ll_scored 1
scoreboard players set @e[tag=ll.board] ll_won 0
scoreboard players set @e[tag=ll.board] ll_bonus 0
scoreboard players set @s ll_high -1
execute as @e[tag=ll.board,scores={ll_alive=1}] run scoreboard players operation @e[tag=ll.current,limit=1] ll_high > @s ll_hand
scoreboard players operation #high ll_ctx = @s ll_high
scoreboard players set @s ll_winners 0
execute as @e[tag=ll.board,scores={ll_alive=1}] if score @s ll_hand = #high ll_ctx run function love_letter:engine/award
scoreboard players set #spies ll_ctx 0
execute as @e[tag=ll.board,scores={ll_alive=1,ll_spy=1}] run scoreboard players add #spies ll_ctx 1
execute if score #spies ll_ctx matches 1 as @e[tag=ll.board,scores={ll_alive=1,ll_spy=1}] run function love_letter:engine/spy_bonus
