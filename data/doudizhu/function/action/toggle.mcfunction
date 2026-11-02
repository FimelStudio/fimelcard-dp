# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 只允许切换本人尚未打出的实体，不能通过手动trigger选择他人牌。
execute as @e[tag=dd.hand] if score @s dd_card = #action dd_ctx run scoreboard players add @s dd_selected 1
execute as @e[tag=dd.hand,scores={dd_selected=2..}] run scoreboard players set @s dd_selected 0
