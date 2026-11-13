# 轮空玩家的下方区域显示第三位在场玩家的公开出牌。
data modify storage doudizhu:hud label set value "场上 "
execute as @e[tag=dd.actor] if score @s dd_id = #hud_table dd_ctx unless score @s dd_seat = #hud_out dd_ctx unless score @s dd_seat = #hud_up dd_ctx unless score @s dd_seat = #hud_down dd_ctx at @s run function doudizhu:hud/row
