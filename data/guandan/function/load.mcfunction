scoreboard objectives add gd_action trigger
scoreboard objectives add gd_actor dummy
scoreboard objectives add gd_anim dummy
scoreboard objectives add gd_clock dummy
scoreboard objectives add gd_count dummy
scoreboard objectives add gd_ctx dummy
scoreboard objectives add gd_dealorder dummy
scoreboard objectives add gd_dealt dummy
scoreboard objectives add gd_done dummy
scoreboard objectives add gd_drop minecraft.dropped:minecraft.purple_dye
scoreboard objectives add gd_epoch dummy
scoreboard objectives add gd_first dummy
scoreboard objectives add gd_firstorder dummy
scoreboard objectives add gd_giftid dummy
scoreboard objectives add gd_high dummy
scoreboard objectives add gd_hud dummy
scoreboard objectives add gd_hud_key dummy
scoreboard objectives add gd_id dummy
scoreboard objectives add gd_kind dummy
scoreboard objectives add gd_lasthi dummy
scoreboard objectives add gd_lastkind dummy
scoreboard objectives add gd_lastpow dummy
scoreboard objectives add gd_lastseat dummy
scoreboard objectives add gd_lastsize dummy
scoreboard objectives add gd_level dummy
scoreboard objectives add gd_limit dummy
scoreboard objectives add gd_matchwin dummy
scoreboard objectives add gd_mode dummy
scoreboard objectives add gd_order dummy
scoreboard objectives add gd_owner dummy
scoreboard objectives add gd_pair dummy
scoreboard objectives add gd_panel dummy
scoreboard objectives add gd_passes dummy
scoreboard objectives add gd_peer dummy
scoreboard objectives add gd_phase dummy
scoreboard objectives add gd_playteam dummy
scoreboard objectives add gd_point dummy
scoreboard objectives add gd_points dummy
scoreboard objectives add gd_power dummy
scoreboard objectives add gd_prev_panel dummy
scoreboard objectives add gd_prevrank dummy
scoreboard objectives add gd_rank dummy
scoreboard objectives add gd_return dummy
scoreboard objectives add gd_returnid dummy
scoreboard objectives add gd_round dummy
scoreboard objectives add gd_rounds dummy
scoreboard objectives add gd_scored dummy
scoreboard objectives add gd_seat dummy
scoreboard objectives add gd_seen dummy
scoreboard objectives add gd_sel dummy
scoreboard objectives add gd_setinput dummy
scoreboard objectives add gd_setload dummy
scoreboard objectives add gd_setnonce dummy
scoreboard objectives add gd_settable dummy
scoreboard objectives add gd_settings trigger
scoreboard objectives add gd_show dummy
scoreboard objectives add gd_size dummy
scoreboard objectives add gd_startlevel dummy
scoreboard objectives add gd_state dummy
scoreboard objectives add gd_steps dummy
scoreboard objectives add gd_strength dummy
scoreboard objectives add gd_suit dummy
scoreboard objectives add gd_table dummy
scoreboard objectives add gd_team dummy
scoreboard objectives add gd_team0 dummy
scoreboard objectives add gd_team1 dummy
scoreboard objectives add gd_tick dummy
scoreboard objectives add gd_timer dummy
scoreboard objectives add gd_tribn dummy
scoreboard objectives add gd_tribute dummy
scoreboard objectives add gd_turn dummy
scoreboard objectives add gd_type dummy
scoreboard objectives add gd_ui_key dummy
scoreboard objectives add gd_ui_load dummy
scoreboard objectives add gd_ui_tmp dummy
scoreboard objectives add gd_uiepoch dummy
scoreboard objectives add gd_used dummy
scoreboard objectives add gd_wild dummy
scoreboard objectives add gd_winner dummy
execute unless score #version gd_ctx matches 1.. run scoreboard players set #version gd_ctx 1
execute unless score #epoch_serial gd_ctx matches 10000..999999 run scoreboard players set #epoch_serial gd_ctx 10000
scoreboard players set #four gd_ctx 4
scoreboard players set #fiftyfour gd_ctx 54
function guandan:cards/constants
scoreboard players add #ui_load gd_ctx 1
scoreboard players reset * gd_action
scoreboard players reset * gd_settings
function guandan:visual/load
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=18}] at @s run function guandan:system/reload

scoreboard objectives add gd_humans dummy
scoreboard objectives add gd_botclock dummy
scoreboard objectives add gd_botepoch dummy
scoreboard objectives add gd_best dummy
scoreboard objectives add gd_bestchoice dummy
scoreboard objectives add gd_botpick dummy
