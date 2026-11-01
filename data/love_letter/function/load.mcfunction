scoreboard objectives add ll_action trigger
scoreboard objectives add ll_actor dummy
scoreboard objectives add ll_alive dummy
scoreboard objectives add ll_alive_n dummy
scoreboard objectives add ll_anim dummy
scoreboard objectives add ll_bonus dummy
scoreboard objectives add ll_card dummy
scoreboard objectives add ll_clock dummy
scoreboard objectives add ll_dealseat dummy
scoreboard objectives add ll_dealstage dummy
scoreboard objectives add ll_discards_setting dummy
scoreboard objectives add ll_drop minecraft.dropped:minecraft.purple_dye
scoreboard objectives add ll_epoch dummy
scoreboard objectives add ll_extra dummy
scoreboard objectives add ll_first dummy
scoreboard objectives add ll_first_setting dummy
scoreboard objectives add ll_goal dummy
scoreboard objectives add ll_goal_setting dummy
scoreboard objectives add ll_guess dummy
scoreboard objectives add ll_hand dummy
scoreboard objectives add ll_high dummy
scoreboard objectives add ll_matchwin dummy
scoreboard objectives add ll_panel dummy
scoreboard objectives add ll_phase dummy
scoreboard objectives add ll_pick dummy
scoreboard objectives add ll_players dummy
scoreboard objectives add ll_points dummy
scoreboard objectives add ll_prev_panel dummy
scoreboard objectives add ll_protect dummy
scoreboard objectives add ll_round dummy
scoreboard objectives add ll_scored dummy
scoreboard objectives add ll_seat dummy
scoreboard objectives add ll_seen dummy
scoreboard objectives add ll_setepoch dummy
scoreboard objectives add ll_setinput dummy
scoreboard objectives add ll_setload dummy
scoreboard objectives add ll_setnonce dummy
scoreboard objectives add ll_settable dummy
scoreboard objectives add ll_settings trigger
scoreboard objectives add ll_spy dummy
scoreboard objectives add ll_state dummy
scoreboard objectives add ll_table dummy
scoreboard objectives add ll_target dummy
scoreboard objectives add ll_tick dummy
scoreboard objectives add ll_time_setting dummy
scoreboard objectives add ll_timeout dummy
scoreboard objectives add ll_timer dummy
scoreboard objectives add ll_turn dummy
scoreboard objectives add ll_ui_load dummy
scoreboard objectives add ll_ui_tmp dummy
scoreboard objectives add ll_winners dummy
scoreboard objectives add ll_won dummy
scoreboard objectives add ll_ctx dummy
execute unless score #version ll_ctx matches 1.. run scoreboard players set #version ll_ctx 1
execute unless score #epoch_serial ll_ctx matches 10000..999999 run scoreboard players set #epoch_serial ll_ctx 10000
scoreboard players set #thousand ll_ctx 1000
scoreboard players add #ui_load ll_ctx 1
scoreboard players reset * ll_action
scoreboard players reset * ll_settings
scoreboard players reset * ll_setnonce
function love_letter:visual/load
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=17}] at @s run function love_letter:system/reload
