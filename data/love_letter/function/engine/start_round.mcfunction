# 仅初始化新一轮；累计好感保留。首位 0 随机，非 0 为实际座号。
function love_letter:system/context
data modify entity @s data.love_letter set value {deck:[],reserve:-1,public:[],action:{}}
data modify entity @s data.ll_private set value {}
data modify entity @s data.ll_buffer set value []
scoreboard players set @e[tag=ll.board] ll_alive 1
scoreboard players set @e[tag=ll.board] ll_hand -1
scoreboard players set @e[tag=ll.board] ll_extra -1
scoreboard players set @e[tag=ll.board] ll_protect 0
scoreboard players set @e[tag=ll.board] ll_spy 0
scoreboard players set @e[tag=ll.board] ll_won 0
scoreboard players set @e[tag=ll.board] ll_bonus 0
execute as @e[tag=ll.board] run data modify entity @s data.discards set value []
scoreboard players set @s ll_scored 0
scoreboard players set @s ll_phase 1
scoreboard players set @s ll_actor 0
scoreboard players set @s ll_card -1
scoreboard players set @s ll_target 0
scoreboard players set @s ll_guess -1
scoreboard players set #players ll_ctx 0
execute as @e[tag=ll.board] run scoreboard players add #players ll_ctx 1
data modify storage love_letter:runtime shuffle set value []
data modify storage love_letter:runtime pool set value [0, 0, 1, 1, 1, 1, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 8, 9]

scoreboard players set #left ll_ctx 21
function love_letter:engine/shuffle
data modify entity @s data.love_letter.deck set from storage love_letter:runtime shuffle
function love_letter:engine/draw
execute store result entity @s data.love_letter.reserve int 1 run scoreboard players get #draw ll_ctx
execute if score #players ll_ctx matches 2 run function love_letter:engine/public_three
execute as @e[tag=ll.board] run function love_letter:engine/deal_one
scoreboard players operation @s ll_turn = @s ll_first
scoreboard players operation #candidate ll_ctx = @s ll_first
scoreboard players set #valid ll_ctx 0
execute as @e[tag=ll.board] if score @s ll_seat = #candidate ll_ctx run scoreboard players set #valid ll_ctx 1
execute unless score #valid ll_ctx matches 1 store result score @s ll_turn run scoreboard players get @e[tag=ll.board,sort=random,limit=1] ll_seat
