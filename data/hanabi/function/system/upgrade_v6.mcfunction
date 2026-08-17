# 第六版加入内置提示牌、恢复牌及恢复弃牌Dialog状态
scoreboard objectives add hb_tool_hint dummy
scoreboard objectives add hb_tool_restore dummy
scoreboard objectives add hb_option dummy
scoreboard objectives add hb_pending_slot dummy
execute as @e[type=minecraft:marker,tag=ct.controller] run function hanabi:game/init_table
scoreboard players add @e[type=minecraft:marker,tag=hb.controller] hb_pending_slot 0
scoreboard players set #version hb_ctx 6
tellraw @a [{text:'[花火] ',color:'light_purple'},{text:'已加入提示牌和弃牌恢复牌。',color:'green'}]
