scoreboard players add #clock bw_ctx 1
execute if score #clock bw_ctx matches 10.. as @e[type=minecraft:marker,tag=bw.controller,scores={bw_state=1..2}] at @s run function bullshit:system/maintenance
execute if score #clock bw_ctx matches 10.. run scoreboard players set #clock bw_ctx 0
execute as @e[type=minecraft:marker,tag=bw.controller,scores={bw_state=1}] at @s run function bullshit:round/tick_question
execute as @e[type=minecraft:marker,tag=bw.controller,scores={bw_state=3,bw_timer=1..}] run scoreboard players remove @s bw_timer 1
execute as @e[type=minecraft:marker,tag=bw.controller,scores={bw_state=3,bw_timer=..0}] at @s run function bullshit:game/return_lobby
# 阅读倒计时先结算，过期染料只清理，不重新打开答案。
execute as @e[type=minecraft:item] at @s if items entity @s contents minecraft:purple_dye[minecraft:custom_data~{bullshit:{tool:'reading'}}] run function bullshit:input/reading_drop
execute as @a[tag=bw.player,scores={bw_drop=1..}] at @s run function bullshit:input/q
execute as @a[tag=bw.player,scores={bw_drop_dye=1..}] at @s run function bullshit:input/q_dye
execute as @a[tag=bw.smart,scores={bw_action=1..}] at @s run function bullshit:action/handle
