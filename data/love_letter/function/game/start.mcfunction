scoreboard players set @s ct_start 0
execute unless score @s ct_joined matches 2..6 run return run function love_letter:game/bad_count
execute if score @s ct_capacity matches 4 unless score @s ct_joined matches 2..4 run return run function love_letter:game/bad_count
execute unless score @s ct_capacity matches 4 unless score @s ct_capacity matches 8 run return fail
scoreboard players operation #table ll_ctx = @s ct_id
scoreboard players set #occupied ll_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #table ll_ctx if items entity @s hotbar.0 * run scoreboard players set #occupied ll_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ll_ctx if items entity @s hotbar.8 * run scoreboard players set #occupied ll_ctx 1
execute if score #occupied ll_ctx matches 1 run return run function love_letter:game/bad_slots
function love_letter:game/clear
function love_letter:game/init_table
function love_letter:system/context
execute as @a[tag=ct.player] if score @s ct_id = #table ll_ctx run function love_letter:player/join
function love_letter:system/context
scoreboard players set @s ll_players 0
execute as @e[tag=ll.board] run scoreboard players add @e[tag=ll.current,limit=1] ll_players 1
execute unless score @s ll_players matches 2..6 run return run function love_letter:game/start_failed
scoreboard players set @s ll_goal 3
execute if score @s ll_players matches 2 run scoreboard players set @s ll_goal 6
execute if score @s ll_players matches 3 run scoreboard players set @s ll_goal 5
execute if score @s ll_players matches 4 run scoreboard players set @s ll_goal 4
execute if score @s ll_goal_setting matches 1..10 run scoreboard players operation @s ll_goal = @s ll_goal_setting
scoreboard players set @s ll_round 0
scoreboard players set @s ll_tick 0
scoreboard players set @s ll_first 99
execute as @e[tag=ll.board] run scoreboard players operation @e[tag=ll.current,limit=1] ll_first < @s ll_seat
execute if score @s ll_first_setting matches 0 run scoreboard players operation @s ll_first = @e[tag=ll.board,sort=random,limit=1] ll_seat
scoreboard players set @s ct_start 1
function love_letter:game/round_begin
function love_letter:log {text:"情书开局成功，已建立本桌独立牌组与参与者"}
