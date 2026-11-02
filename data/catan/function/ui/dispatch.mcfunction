execute if score #code ca_ctx matches 300 unless score @s ca_panel matches 1 run return run function catan:ui/open
execute if score #code ca_ctx matches 501..504 unless score @s ca_panel matches 2 run return run function catan:ui/open
execute if score #code ca_ctx matches 600..603 unless score @s ca_panel matches 4 run return run function catan:ui/open
execute if score #code ca_ctx matches 1000..1141 unless score @s ca_panel matches 3 run return run function catan:ui/open
execute if score #code ca_ctx matches 350..354 unless score @s ca_panel matches 3 run return run function catan:ui/open
execute if score #code ca_ctx matches 360..361 unless score @s ca_panel matches 5 run return run function catan:ui/open
execute if score #code ca_ctx matches 1000..1014 unless score @s ca_edit matches 1..2 run return run function catan:ui/open
execute if score #code ca_ctx matches 1020..1034 unless score @s ca_edit matches 2 run return run function catan:ui/open
execute if score #code ca_ctx matches 1100..1114 unless score @s ca_edit matches 3 run return run function catan:ui/open
execute if score #code ca_ctx matches 1120..1134 unless score @s ca_edit matches 4..5 run return run function catan:ui/open
execute if score #code ca_ctx matches 1140..1141 unless score @s ca_edit matches 3 run return run function catan:ui/open
execute if score #code ca_ctx matches 350 unless score @s ca_edit matches 2 run return run function catan:ui/open
execute if score #code ca_ctx matches 351 unless score @s ca_edit matches 1 run return run function catan:ui/open
execute if score #code ca_ctx matches 352 unless score @s ca_edit matches 3 run return run function catan:ui/open
execute if score #code ca_ctx matches 353 unless score @s ca_edit matches 4 run return run function catan:ui/open
execute if score #code ca_ctx matches 354 unless score @s ca_edit matches 5 run return run function catan:ui/open
execute if score #code ca_ctx matches 10 run return run function catan:ui/simple {code:10}
execute if score #code ca_ctx matches 23 run return run function catan:ui/simple {code:23}
execute if score #code ca_ctx matches 29 run return run function catan:ui/simple {code:29}
execute if score #code ca_ctx matches 31 run return run function catan:ui/simple {code:31}
execute if score #code ca_ctx matches 100 run return run function catan:input/aim
execute if score #code ca_ctx matches 102 run scoreboard players set @s ca_mode 2
execute if score #code ca_ctx matches 102 run return run function catan:ui/aim_note
execute if score #code ca_ctx matches 103 run scoreboard players set @s ca_mode 3
execute if score #code ca_ctx matches 103 run return run function catan:ui/aim_note
execute if score #code ca_ctx matches 104 run scoreboard players set @s ca_mode 4
execute if score #code ca_ctx matches 104 run return run function catan:ui/aim_note
execute if score #code ca_ctx matches 200 run return run function catan:ui/partners
execute if score #code ca_ctx matches 210 run return run function catan:ui/bank
execute if score #code ca_ctx matches 220 run return run function catan:ui/development
execute if score #code ca_ctx matches 230 run return run function catan:ui/discard
execute if score #code ca_ctx matches 240 run return run function catan:ui/trade_response
execute if score #code ca_ctx matches 250 run return run function catan:ui/music
execute if score #code ca_ctx matches 260 run return run function catan:ui/rules
execute if score #code ca_ctx matches 300 run return run function catan:ui/place
execute if score #code ca_ctx matches 350 run return run function catan:ui/send_trade
execute if score #code ca_ctx matches 351 run return run function catan:ui/send_discard
execute if score #code ca_ctx matches 352 run return run function catan:ui/send_bank
execute if score #code ca_ctx matches 353 run return run function catan:ui/send_monopoly
execute if score #code ca_ctx matches 354 run return run function catan:ui/send_plenty
execute if score #code ca_ctx matches 360 run return run function catan:ui/accept
execute if score #code ca_ctx matches 361 run return run function catan:ui/refuse
execute if score #code ca_ctx matches 401 run return run function catan:ui/steal {target:1}
execute if score #code ca_ctx matches 501 run scoreboard players set @s ca_partner 1
execute if score #code ca_ctx matches 501 run return run function catan:ui/trade_begin
execute if score #code ca_ctx matches 402 run return run function catan:ui/steal {target:2}
execute if score #code ca_ctx matches 502 run scoreboard players set @s ca_partner 2
execute if score #code ca_ctx matches 502 run return run function catan:ui/trade_begin
execute if score #code ca_ctx matches 403 run return run function catan:ui/steal {target:3}
execute if score #code ca_ctx matches 503 run scoreboard players set @s ca_partner 3
execute if score #code ca_ctx matches 503 run return run function catan:ui/trade_begin
execute if score #code ca_ctx matches 404 run return run function catan:ui/steal {target:4}
execute if score #code ca_ctx matches 504 run scoreboard players set @s ca_partner 4
execute if score #code ca_ctx matches 504 run return run function catan:ui/trade_begin
execute if score #code ca_ctx matches 600 run return run function catan:ui/dev_0
execute if score #code ca_ctx matches 601 run return run function catan:ui/dev_1
execute if score #code ca_ctx matches 602 run return run function catan:ui/dev_2
execute if score #code ca_ctx matches 603 run return run function catan:ui/dev_3
execute if score #code ca_ctx matches 1000 run scoreboard players add @s ca_g0 1
execute if score @s ca_g0 matches ..-1 run scoreboard players set @s ca_g0 0
execute if score @s ca_g0 matches 20.. run scoreboard players set @s ca_g0 19
execute if score #code ca_ctx matches 1000 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1010 run scoreboard players remove @s ca_g0 1
execute if score @s ca_g0 matches ..-1 run scoreboard players set @s ca_g0 0
execute if score @s ca_g0 matches 20.. run scoreboard players set @s ca_g0 19
execute if score #code ca_ctx matches 1010 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1020 run scoreboard players add @s ca_w0 1
execute if score @s ca_w0 matches ..-1 run scoreboard players set @s ca_w0 0
execute if score @s ca_w0 matches 20.. run scoreboard players set @s ca_w0 19
execute if score #code ca_ctx matches 1020 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1030 run scoreboard players remove @s ca_w0 1
execute if score @s ca_w0 matches ..-1 run scoreboard players set @s ca_w0 0
execute if score @s ca_w0 matches 20.. run scoreboard players set @s ca_w0 19
execute if score #code ca_ctx matches 1030 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1100 run scoreboard players set @s ca_pay 0
execute if score #code ca_ctx matches 1100 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1110 run scoreboard players set @s ca_receive 0
execute if score #code ca_ctx matches 1110 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1120 run scoreboard players set @s ca_a 0
execute if score #code ca_ctx matches 1120 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1130 run scoreboard players set @s ca_b 0
execute if score #code ca_ctx matches 1130 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1001 run scoreboard players add @s ca_g1 1
execute if score @s ca_g1 matches ..-1 run scoreboard players set @s ca_g1 0
execute if score @s ca_g1 matches 20.. run scoreboard players set @s ca_g1 19
execute if score #code ca_ctx matches 1001 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1011 run scoreboard players remove @s ca_g1 1
execute if score @s ca_g1 matches ..-1 run scoreboard players set @s ca_g1 0
execute if score @s ca_g1 matches 20.. run scoreboard players set @s ca_g1 19
execute if score #code ca_ctx matches 1011 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1021 run scoreboard players add @s ca_w1 1
execute if score @s ca_w1 matches ..-1 run scoreboard players set @s ca_w1 0
execute if score @s ca_w1 matches 20.. run scoreboard players set @s ca_w1 19
execute if score #code ca_ctx matches 1021 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1031 run scoreboard players remove @s ca_w1 1
execute if score @s ca_w1 matches ..-1 run scoreboard players set @s ca_w1 0
execute if score @s ca_w1 matches 20.. run scoreboard players set @s ca_w1 19
execute if score #code ca_ctx matches 1031 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1101 run scoreboard players set @s ca_pay 1
execute if score #code ca_ctx matches 1101 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1111 run scoreboard players set @s ca_receive 1
execute if score #code ca_ctx matches 1111 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1121 run scoreboard players set @s ca_a 1
execute if score #code ca_ctx matches 1121 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1131 run scoreboard players set @s ca_b 1
execute if score #code ca_ctx matches 1131 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1002 run scoreboard players add @s ca_g2 1
execute if score @s ca_g2 matches ..-1 run scoreboard players set @s ca_g2 0
execute if score @s ca_g2 matches 20.. run scoreboard players set @s ca_g2 19
execute if score #code ca_ctx matches 1002 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1012 run scoreboard players remove @s ca_g2 1
execute if score @s ca_g2 matches ..-1 run scoreboard players set @s ca_g2 0
execute if score @s ca_g2 matches 20.. run scoreboard players set @s ca_g2 19
execute if score #code ca_ctx matches 1012 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1022 run scoreboard players add @s ca_w2 1
execute if score @s ca_w2 matches ..-1 run scoreboard players set @s ca_w2 0
execute if score @s ca_w2 matches 20.. run scoreboard players set @s ca_w2 19
execute if score #code ca_ctx matches 1022 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1032 run scoreboard players remove @s ca_w2 1
execute if score @s ca_w2 matches ..-1 run scoreboard players set @s ca_w2 0
execute if score @s ca_w2 matches 20.. run scoreboard players set @s ca_w2 19
execute if score #code ca_ctx matches 1032 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1102 run scoreboard players set @s ca_pay 2
execute if score #code ca_ctx matches 1102 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1112 run scoreboard players set @s ca_receive 2
execute if score #code ca_ctx matches 1112 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1122 run scoreboard players set @s ca_a 2
execute if score #code ca_ctx matches 1122 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1132 run scoreboard players set @s ca_b 2
execute if score #code ca_ctx matches 1132 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1003 run scoreboard players add @s ca_g3 1
execute if score @s ca_g3 matches ..-1 run scoreboard players set @s ca_g3 0
execute if score @s ca_g3 matches 20.. run scoreboard players set @s ca_g3 19
execute if score #code ca_ctx matches 1003 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1013 run scoreboard players remove @s ca_g3 1
execute if score @s ca_g3 matches ..-1 run scoreboard players set @s ca_g3 0
execute if score @s ca_g3 matches 20.. run scoreboard players set @s ca_g3 19
execute if score #code ca_ctx matches 1013 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1023 run scoreboard players add @s ca_w3 1
execute if score @s ca_w3 matches ..-1 run scoreboard players set @s ca_w3 0
execute if score @s ca_w3 matches 20.. run scoreboard players set @s ca_w3 19
execute if score #code ca_ctx matches 1023 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1033 run scoreboard players remove @s ca_w3 1
execute if score @s ca_w3 matches ..-1 run scoreboard players set @s ca_w3 0
execute if score @s ca_w3 matches 20.. run scoreboard players set @s ca_w3 19
execute if score #code ca_ctx matches 1033 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1103 run scoreboard players set @s ca_pay 3
execute if score #code ca_ctx matches 1103 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1113 run scoreboard players set @s ca_receive 3
execute if score #code ca_ctx matches 1113 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1123 run scoreboard players set @s ca_a 3
execute if score #code ca_ctx matches 1123 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1133 run scoreboard players set @s ca_b 3
execute if score #code ca_ctx matches 1133 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1004 run scoreboard players add @s ca_g4 1
execute if score @s ca_g4 matches ..-1 run scoreboard players set @s ca_g4 0
execute if score @s ca_g4 matches 20.. run scoreboard players set @s ca_g4 19
execute if score #code ca_ctx matches 1004 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1014 run scoreboard players remove @s ca_g4 1
execute if score @s ca_g4 matches ..-1 run scoreboard players set @s ca_g4 0
execute if score @s ca_g4 matches 20.. run scoreboard players set @s ca_g4 19
execute if score #code ca_ctx matches 1014 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1024 run scoreboard players add @s ca_w4 1
execute if score @s ca_w4 matches ..-1 run scoreboard players set @s ca_w4 0
execute if score @s ca_w4 matches 20.. run scoreboard players set @s ca_w4 19
execute if score #code ca_ctx matches 1024 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1034 run scoreboard players remove @s ca_w4 1
execute if score @s ca_w4 matches ..-1 run scoreboard players set @s ca_w4 0
execute if score @s ca_w4 matches 20.. run scoreboard players set @s ca_w4 19
execute if score #code ca_ctx matches 1034 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1104 run scoreboard players set @s ca_pay 4
execute if score #code ca_ctx matches 1104 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1114 run scoreboard players set @s ca_receive 4
execute if score #code ca_ctx matches 1114 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1124 run scoreboard players set @s ca_a 4
execute if score #code ca_ctx matches 1124 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1134 run scoreboard players set @s ca_b 4
execute if score #code ca_ctx matches 1134 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1140 run scoreboard players add @s ca_batch 1
execute if score @s ca_batch matches ..0 run scoreboard players set @s ca_batch 1
execute if score @s ca_batch matches 20.. run scoreboard players set @s ca_batch 19
execute if score #code ca_ctx matches 1140 run return run function catan:ui/editor
execute if score #code ca_ctx matches 1141 run scoreboard players remove @s ca_batch 1
execute if score @s ca_batch matches ..0 run scoreboard players set @s ca_batch 1
execute if score @s ca_batch matches 20.. run scoreboard players set @s ca_batch 19
execute if score #code ca_ctx matches 1141 run return run function catan:ui/editor
