scoreboard players remove @s ll_timer 1
execute if score @s ll_timer matches 1.. run return 0
execute if score @s ll_dealstage matches 1 run return run function love_letter:game/first_turn
function love_letter:system/context
scoreboard players set #deal_seat ll_ctx 99
scoreboard players operation #last_dealt ll_ctx = @s ll_dealseat
execute as @e[tag=ll.board] if score @s ll_seat > #last_dealt ll_ctx run scoreboard players operation #deal_seat ll_ctx < @s ll_seat
execute if score #deal_seat ll_ctx matches 99 run return run function love_letter:deal/wait
scoreboard players operation @s ll_dealseat = #deal_seat ll_ctx
function love_letter:deal/launch
scoreboard players set @s ll_timer 3
