scoreboard players set #valid ll_ctx 0
function love_letter:engine/validate
execute unless score #valid ll_ctx matches 1 run return 0
execute unless score @s ll_phase matches 1 run return 0
execute unless score @s ll_turn = #actor ll_ctx run return 0
execute unless score #slot ll_ctx matches 0..1 run return 0
scoreboard players operation #hand ll_ctx = @e[tag=ll.engine_actor,limit=1] ll_hand
scoreboard players operation #extra ll_ctx = @e[tag=ll.engine_actor,limit=1] ll_extra
execute unless score #hand ll_ctx matches 0..9 run return 0
execute unless score #extra ll_ctx matches 0..9 run return 0
scoreboard players operation #card ll_ctx = #hand ll_ctx
scoreboard players operation #other ll_ctx = #extra ll_ctx
execute if score #slot ll_ctx matches 1 run scoreboard players operation #card ll_ctx = #extra ll_ctx
execute if score #slot ll_ctx matches 1 run scoreboard players operation #other ll_ctx = #hand ll_ctx
scoreboard players set #forced ll_ctx 0
execute if score #hand ll_ctx matches 8 if score #extra ll_ctx matches 5 run scoreboard players set #forced ll_ctx 1
execute if score #hand ll_ctx matches 8 if score #extra ll_ctx matches 7 run scoreboard players set #forced ll_ctx 1
execute if score #extra ll_ctx matches 8 if score #hand ll_ctx matches 5 run scoreboard players set #forced ll_ctx 1
execute if score #extra ll_ctx matches 8 if score #hand ll_ctx matches 7 run scoreboard players set #forced ll_ctx 1
scoreboard players set #error ll_ctx 2
execute if score #forced ll_ctx matches 1 unless score #card ll_ctx matches 8 run return 0
data modify entity @s data.love_letter.action set value {actor:0,card:0,target:0,guess:-1,eliminated:[],forced:-1}
execute store result entity @s data.love_letter.action.actor int 1 run scoreboard players get #actor ll_ctx
execute store result entity @s data.love_letter.action.card int 1 run scoreboard players get #card ll_ctx
data modify entity @s data.ll_private set value {}
data modify entity @s data.ll_buffer set value []
scoreboard players operation @s ll_actor = #actor ll_ctx
scoreboard players operation @s ll_card = #card ll_ctx
scoreboard players set @s ll_target 0
scoreboard players set @s ll_guess -1
scoreboard players operation @e[tag=ll.engine_actor,limit=1] ll_hand = #other ll_ctx
scoreboard players set @e[tag=ll.engine_actor] ll_extra -1
scoreboard players operation #discard ll_ctx = #card ll_ctx
execute as @e[tag=ll.engine_actor] run function love_letter:engine/discard
function love_letter:engine/dispatch
scoreboard players set #ok ll_ctx 1
scoreboard players set #error ll_ctx 0
