execute as @a[scores={ct_skin_pick=1..}] at @s run function cardtable:skin/handle
# 上一刻不在线却仍保留牌桌身份，说明该玩家离线后刚刚返回
# 先通过游戏分派清除其旧游戏状态，再释放旧座位
execute as @a[tag=ct.player] unless score @s ct_online matches 1 run function cardtable:game/remove_offline_player

# 普通玩家通过一次性trigger提交游戏选择。
execute as @a[scores={ct_game_pick=1..}] at @s run function cardtable:menu/picker/handle

# 只有仍在空中飞行的公共发牌物品才需要逐刻处理
execute as @e[type=minecraft:item,tag=ct.dealt_card] at @s run function cardtable:animation/deal/flying_tick

# 大厅中的玩家主动离座后自动退出；每半秒检测一次即可
scoreboard players add #clock ct_ctx 1
execute if score #clock ct_ctx matches 10.. as @a[tag=ct.player] at @s run function cardtable:seat/lobby_check

# 在座位时按空格即可触发meme对话框
function cardtable:meme/tick

# 牌桌人数以当前在线且仍持有牌桌身份的玩家为准，离线后座位立即变为空闲
execute if score #clock ct_ctx matches 10.. as @e[type=minecraft:marker,tag=ct.controller] at @s run function cardtable:table/recount_players

# 旧牌桌或启动时尚未加载实体的牌桌只执行一次第十三版迁移
execute if score #clock ct_ctx matches 10.. as @e[type=minecraft:marker,tag=ct.controller] at @s unless data entity @s {data:{cardtable:{menu_version:13}}} run function cardtable:table/migrate_v13
# 尚未加载的八人桌也补做座椅迁移，只执行一次。
execute if score #clock ct_ctx matches 10.. as @e[type=minecraft:marker,tag=ct.controller,scores={ct_capacity=8}] at @s unless data entity @s {data:{cardtable:{chairs_version:1}}} run function cardtable:table/migrate_chairs8
# 未加载区块中的旧按钮，在牌桌重新加载后只更新一次。
execute if score #clock ct_ctx matches 10.. as @e[type=minecraft:marker,tag=ct.controller] at @s unless data entity @s {data:{cardtable:{rules_version:5}}} run function cardtable:rules/render
# 玩家离线后补回缺座；重新上线带回旧载具后，只移除重复空座。
execute if score #clock ct_ctx matches 10.. as @e[type=minecraft:marker,tag=ct.controller] at @s run function cardtable:table/ensure_seats
# 已加载的八人桌补做结束按钮布局更新，不重置投票。
execute if score #clock ct_ctx matches 10.. as @e[type=minecraft:marker,tag=ct.controller,scores={ct_capacity=8,ct_state=1}] at @s unless data entity @s {data:{cardtable:{vote_version:1}}} run function cardtable:vote/render
execute if score #clock ct_ctx matches 10.. as @e[type=minecraft:item_display,tag=ct.skin,tag=!ct.sofa_v2] at @s if items entity @s contents minecraft:paper[minecraft:item_model="card:table_skin/sofa"] run function cardtable:skin/rotate_sofa
execute if score #clock ct_ctx matches 10.. as @e[type=minecraft:item_display,tag=ct.skin,tag=!ct.theme_chair_v2] at @s if items entity @s contents minecraft:paper[minecraft:item_model="card:table_skin/bamboo_chair"] run function cardtable:skin/rotate_theme_chair
execute if score #clock ct_ctx matches 10.. as @e[type=minecraft:item_display,tag=ct.skin,tag=!ct.theme_chair_v2] at @s if items entity @s contents minecraft:paper[minecraft:item_model="card:table_skin/garden_chair"] run function cardtable:skin/rotate_theme_chair
execute if score #clock ct_ctx matches 10.. run scoreboard players set #clock ct_ctx 0

# 每刻末尾更新在线心跳；离线玩家的记分会保持为0
scoreboard players set * ct_online 0
scoreboard players set @a[tag=ct.player] ct_online 1
