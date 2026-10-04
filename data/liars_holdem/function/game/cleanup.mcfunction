# 统一清理入口：正常结束、投票结束和管理员中止均可安全调用
scoreboard players operation #ctx_id lh_ctx = @s lh_id
function liars_holdem:round/cleanup
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run function liars_holdem:player/clear_state
tag @a[tag=lh.final_winner] remove lh.final_winner
tag @a[tag=lh.action_actor] remove lh.action_actor
tag @a[tag=lh.swap_actor] remove lh.swap_actor
tag @a[tag=lh.gun_target] remove lh.gun_target

scoreboard players set @s lh_state 0
scoreboard players set @s lh_phase 0
scoreboard players set @s lh_timer 0
scoreboard players reset @s lh_id
scoreboard players reset @s lh_round
scoreboard players reset @s lh_dealer
scoreboard players reset @s lh_turn
scoreboard players reset @s lh_a1
scoreboard players reset @s lh_a2
scoreboard players reset @s lh_a3
scoreboard players reset @s lh_a4
scoreboard players reset @s lh_a5
scoreboard players reset @s lh_a6
scoreboard players reset @s lh_a7
scoreboard players reset @s lh_a8
tag @s remove lh.controller
function cardtable:table/recount_players
function cardtable:game/return_lobby
