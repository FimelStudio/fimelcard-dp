scoreboard players operation #rejoin_table ct_ctx = @s ct_id
scoreboard players set #rejoin_found ct_ctx 0
scoreboard players set #rejoin_valid ct_ctx 0
tag @s add ct.reconnect_actor
execute in minecraft:overworld as @e[type=minecraft:marker,tag=ct.controller,distance=0..] at @s if score @s ct_id = #rejoin_table ct_ctx run function cardtable:session/reconcile_at_table
execute in minecraft:the_nether as @e[type=minecraft:marker,tag=ct.controller,distance=0..] at @s if score @s ct_id = #rejoin_table ct_ctx run function cardtable:session/reconcile_at_table
execute in minecraft:the_end as @e[type=minecraft:marker,tag=ct.controller,distance=0..] at @s if score @s ct_id = #rejoin_table ct_ctx run function cardtable:session/reconcile_at_table
tag @s remove ct.reconnect_actor
execute if score #rejoin_valid ct_ctx matches 1 run return 1
execute if score #rejoin_found ct_ctx matches 1 run return run function cardtable:game/remove_offline_player
# 会话注册表独立于实体区块；桌暂未载入时绝不误清仍在进行的局。
execute if score @s ct_session matches 1.. run return run function cardtable:session/reconcile_unloaded
# 升级前没有会话号的旧成员使用短暂载入宽限。
scoreboard players add @s ct_rejoin 1
execute if score @s ct_rejoin matches 40.. run function cardtable:game/remove_offline_player
