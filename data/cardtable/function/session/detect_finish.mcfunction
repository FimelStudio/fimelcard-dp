# 必须先于重连和旧局迁移；终局不能重新接回离线成员或再次暂停。
execute if score @s ct_finishing matches 1 run return 0
execute if score @s ct_game matches 2 if score @s lh_state matches 17 run return run function cardtable:session/finish
execute if score @s ct_game matches 3 if score @s hb_state matches 3 run return run function cardtable:session/finish
execute if score @s ct_game matches 4 if score @s ab_state matches 3 run return run function cardtable:session/finish
execute if score @s ct_game matches 7 if score @s cp_state matches 4 run return run function cardtable:session/finish
execute if score @s ct_game matches 10 if score @s dd_state matches 4 if score @s dd_round >= @s dd_limit run return run function cardtable:session/finish
execute if score @s ct_game matches 11 if score @s un_state matches 5 if score @s un_matchend matches 1 run return run function cardtable:session/finish
execute if score @s ct_game matches 12 if score @s ch_state matches 4 run return run function cardtable:session/finish
execute if score @s ct_game matches 13 if score @s xq_state matches 4 run return run function cardtable:session/finish
execute if score @s ct_game matches 14 if score @s gm_state matches 4 run return run function cardtable:session/finish
execute if score @s ct_game matches 15 if score @s ac_state matches 5 run return run function cardtable:session/finish
execute if score @s ct_game matches 16 if score @s av_state matches 5 run return run function cardtable:session/finish
execute if score @s ct_game matches 17 if score @s ll_state matches 4 run return run function cardtable:session/finish
execute if score @s ct_game matches 18 if score @s gd_state matches 5 run return run function cardtable:session/finish
execute if score @s ct_game matches 19 if score @s it_state matches 4 run return run function cardtable:session/finish
execute if score @s ct_game matches 20 if score @s go_state matches 4 run return run function cardtable:session/finish
execute if score @s ct_game matches 21 if score @s ca_state matches 11 run return run function cardtable:session/finish
execute if score @s ct_game matches 22 if score @s sp_state matches 4 run return run function cardtable:session/finish
execute if score @s ct_game matches 23 if score @s ma_state matches 5 run return run function cardtable:session/finish
