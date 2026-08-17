# 上一刻不在线却仍保留牌桌身份，说明该玩家离线后刚刚返回
# 先通过游戏分派清除其旧游戏状态，再释放旧座位
execute as @a[tag=ct.player] unless score @s ct_online matches 1 run function cardtable:game/remove_offline_player

# 只有仍在空中飞行的公共发牌物品才需要逐刻处理
execute as @e[type=minecraft:item,tag=ct.dealt_card] at @s run function cardtable:animation/deal/flying_tick

# 大厅中的玩家主动离座后自动退出；每半秒检测一次即可
scoreboard players add #clock ct_ctx 1
execute if score #clock ct_ctx matches 10.. as @a[tag=ct.player] at @s run function cardtable:seat/lobby_check

# 牌桌人数以当前在线且仍持有牌桌身份的玩家为准，离线后座位立即变为空闲
execute if score #clock ct_ctx matches 10.. as @e[type=minecraft:marker,tag=ct.controller] at @s run function cardtable:table/recount_players

# 旧牌桌或启动时尚未加载实体的牌桌只执行一次第十二版迁移
execute if score #clock ct_ctx matches 10.. as @e[type=minecraft:marker,tag=ct.controller] at @s unless data entity @s {data:{cardtable:{menu_version:12}}} run function cardtable:table/migrate_v12
execute if score #clock ct_ctx matches 10.. run scoreboard players set #clock ct_ctx 0

# 每刻末尾更新在线心跳；离线玩家的记分会保持为0
scoreboard players set * ct_online 0
scoreboard players set @a[tag=ct.player] ct_online 1
