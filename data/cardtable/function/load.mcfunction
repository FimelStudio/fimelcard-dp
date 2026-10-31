scoreboard objectives add ct_meme trigger
scoreboard objectives add ct_meme_cd dummy
scoreboard objectives add ct_voice_cd dummy
scoreboard players reset * ct_meme
tag @a remove ct.meme_jump
# 创建通用牌桌模块的安装标记
scoreboard objectives add ct_ctx dummy

# 仅在首次安装或通用模块升级时创建其余记分项
execute unless score #version ct_ctx matches 1.. run function cardtable:system/install
execute if score #version ct_ctx matches 1 run function cardtable:system/upgrade_v2
execute if score #version ct_ctx matches 2 run function cardtable:system/upgrade_v3
execute if score #version ct_ctx matches 3 run function cardtable:system/upgrade_v4
execute if score #version ct_ctx matches 4 run function cardtable:system/upgrade_v5

# 重载后旧选择窗口失效；保留所有实际游戏设置和进度。
scoreboard players reset * ct_game_pick
scoreboard players reset * ct_pick_table
scoreboard players reset * ct_pick_base

# 当前注册游戏编号必须连续排列
scoreboard players set #game_count ct_ctx 15

# 重载时升级已加载牌桌；尚未加载的牌桌会由低频维护逻辑补做
execute as @e[type=minecraft:marker,tag=ct.controller] at @s unless data entity @s {data:{cardtable:{menu_version:13}}} run function cardtable:table/migrate_v13

# 将旧八人桌的实体座位与椅子更新为每侧间隔1格的布局。
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_capacity=8}] at @s unless data entity @s {data:{cardtable:{chairs_version:1}}} run function cardtable:table/migrate_chairs8

# 规则按钮独立刷新，已建桌也立即采用当前桌型的外沿坐标。
execute as @e[type=minecraft:marker,tag=ct.controller] at @s run function cardtable:table/ensure_seats

execute as @e[type=minecraft:marker,tag=ct.controller] at @s run function cardtable:rules/render

# 八人桌结束按钮采用新的内收布局，保留已有票数。
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_capacity=8,ct_state=1}] at @s run function cardtable:vote/render

# 立即修复重载前已经存在的牌桌与游戏文本，避免必须重建牌桌才能获得方块遮挡
function cardtable:display/repair_occlusion

# 修复旧版牌盒未成功绑定标签而遗留的微小模型，不中断正常发牌动画。
execute as @e[type=minecraft:marker,tag=ct.controller] at @s run function cardtable:animation/deal/box/cleanup_legacy

tellraw @a[tag=ct.player] [{text:'[牌桌] ',color:'dark_aqua'},{text:'通用牌桌模块已重新加载。',color:'yellow'}]

scoreboard objectives add ct_skin dummy
scoreboard objectives add ct_skin_pick trigger
scoreboard objectives add ct_skin_table dummy
scoreboard players reset * ct_skin_pick
scoreboard players reset * ct_skin_table

# 旧典雅沙发转向，保留正在进行的游戏。
execute as @e[type=minecraft:item_display,tag=ct.skin,tag=!ct.sofa_v2] at @s if items entity @s contents minecraft:paper[minecraft:item_model="card:table_skin/sofa"] run function cardtable:skin/rotate_sofa

execute as @e[type=minecraft:item_display,tag=ct.skin,tag=!ct.theme_chair_v2] at @s if items entity @s contents minecraft:paper[minecraft:item_model="card:table_skin/bamboo_chair"] run function cardtable:skin/rotate_theme_chair
execute as @e[type=minecraft:item_display,tag=ct.skin,tag=!ct.theme_chair_v2] at @s if items entity @s contents minecraft:paper[minecraft:item_model="card:table_skin/garden_chair"] run function cardtable:skin/rotate_theme_chair

# 关闭已有牌桌家具的亮度覆盖。
function cardtable:display/repair_furniture_brightness
