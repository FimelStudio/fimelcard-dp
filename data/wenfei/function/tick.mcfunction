# 兼容更新前已结算、正在等待准备的对局，直接继续，不重复计分。
execute as @e[type=minecraft:marker,tag=wq.controller,scores={wq_state=4}] at @s run function wenfei:round/next
execute as @a[scores={wq_settings=1..}] run function wenfei:settings/save
execute as @a[tag=wq.player,scores={wq_action=1..}] run function wenfei:action/handle
scoreboard players add #clock wq_ctx 1
execute if score #clock wq_ctx matches 10.. as @e[type=minecraft:marker,tag=wq.controller,scores={wq_state=1..4}] at @s run function wenfei:system/maintenance
execute if score #clock wq_ctx matches 10.. run scoreboard players set #clock wq_ctx 0
# 只扫描本桌在线玩家身边的专属掉落工具，距牌桌远近不影响操作。
execute as @e[type=minecraft:marker,tag=wq.controller,scores={wq_state=1..4}] at @s run function wenfei:input/scan

execute as @e[type=minecraft:marker,tag=wq.controller,scores={wq_state=3}] at @s run function wenfei:title/tick
