# uninstall-guard: begin (tools/build_uninstall.py)
execute if data storage cardtable:uninstall active run return 0
execute unless score #version ct_ctx matches 1.. run return 0
# uninstall-guard: end
# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players add #clock bw_ctx 1
execute if score #clock bw_ctx matches 10.. as @e[type=minecraft:marker,tag=bw.controller,scores={bw_state=1..2}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function bullshit:system/maintenance
execute if score #clock bw_ctx matches 10.. run scoreboard players set #clock bw_ctx 0
execute as @e[type=minecraft:marker,tag=bw.controller,scores={bw_state=1}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function bullshit:round/tick_question
execute as @e[type=minecraft:marker,tag=bw.controller,scores={bw_state=3,bw_timer=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] run scoreboard players remove @s bw_timer 1
execute as @e[type=minecraft:marker,tag=bw.controller,scores={bw_state=3,bw_timer=..0}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function bullshit:game/return_lobby
# 阅读倒计时先结算，过期染料只清理，不重新打开答案。
execute as @e[type=minecraft:item] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s if items entity @s contents minecraft:purple_dye[minecraft:custom_data~{bullshit:{tool:'reading'}}] run function bullshit:input/reading_drop
execute as @a[tag=bw.player,scores={bw_drop=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function bullshit:input/q
execute as @a[tag=bw.player,scores={bw_drop_dye=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function bullshit:input/q_dye
execute as @a[tag=bw.smart,scores={bw_action=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function bullshit:action/handle
