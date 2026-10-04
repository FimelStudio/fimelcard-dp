# 只允许切换本人尚未打出的实体，不能通过手动trigger选择他人牌。
execute as @e[tag=dd.hand] if score @s dd_card = #action dd_ctx run scoreboard players add @s dd_selected 1
execute as @e[tag=dd.hand,scores={dd_selected=2..}] run scoreboard players set @s dd_selected 0
