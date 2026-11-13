scoreboard players set #hud_ticks ct_ctx 0
execute if entity @e[tag=dd.current,scores={dd_state=2..3,dd_turn_clock=1..},limit=1] if score @s dd_seat = @e[tag=dd.current,limit=1] dd_turn run scoreboard players operation #hud_ticks ct_ctx = @e[tag=dd.current,limit=1] dd_turn_clock
execute if entity @e[tag=dd.current,scores={dd_state=2,dd_bidmode=2},limit=1] run scoreboard players set #hud_ticks ct_ctx 300
execute if score #hud_ticks ct_ctx matches 300 run scoreboard players operation #hud_ticks ct_ctx -= @e[tag=dd.current,limit=1] dd_speed_time
# 无牌可跟的倒计时只显示给当前行动者。
execute if entity @e[tag=dd.current,scores={dd_state=3,dd_autopass=1..100},limit=1] if score @s dd_seat = #hud_viewer dd_ctx if score @s dd_seat = @e[tag=dd.current,limit=1] dd_auto_seat run scoreboard players operation #hud_ticks ct_ctx = @e[tag=dd.current,limit=1] dd_autopass
execute if score #hud_ticks ct_ctx matches 1.. run function cardtable:hud/append_countdown
