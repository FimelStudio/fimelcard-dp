# 会话编号持久递增，重载不重置；离线玩家的旧编号留待重新上线核验。
scoreboard objectives add ct_session dummy
scoreboard objectives add ct_expected dummy
scoreboard objectives add ct_paused dummy
scoreboard objectives add ct_rejoin dummy
scoreboard objectives add ct_wait dummy
execute unless score #session ct_ctx matches 0.. run scoreboard players set #session ct_ctx 0
execute in minecraft:overworld as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_state=1}] at @s unless score @s ct_session matches 1.. run function cardtable:session/migrate
execute in minecraft:the_nether as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_state=1}] at @s unless score @s ct_session matches 1.. run function cardtable:session/migrate
execute in minecraft:the_end as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_state=1}] at @s unless score @s ct_session matches 1.. run function cardtable:session/migrate
execute in minecraft:overworld as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_state=1,ct_session=1..}] run function cardtable:session/mark_active
execute in minecraft:the_nether as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_state=1,ct_session=1..}] run function cardtable:session/mark_active
execute in minecraft:the_end as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_state=1,ct_session=1..}] run function cardtable:session/mark_active
