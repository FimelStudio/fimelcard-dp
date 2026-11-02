# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s ca_g0 0
scoreboard players set @s ca_g1 0
scoreboard players set @s ca_g2 0
scoreboard players set @s ca_g3 0
scoreboard players set @s ca_g4 0
scoreboard players set @s ca_w0 0
scoreboard players set @s ca_w1 0
scoreboard players set @s ca_w2 0
scoreboard players set @s ca_w3 0
scoreboard players set @s ca_w4 0
scoreboard players set @s ca_partner 0
scoreboard players set @s ca_pay 0
scoreboard players set @s ca_receive 1
scoreboard players set @s ca_batch 1
scoreboard players set @s ca_a 0
scoreboard players set @s ca_b 1
scoreboard players set @s ca_edit 0
scoreboard players set @s ca_panel 0
scoreboard players set @s ca_trade_id -1
