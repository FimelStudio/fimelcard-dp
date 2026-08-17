# 创建通用牌桌模块的安装标记
scoreboard objectives add ct_ctx dummy

# 仅在首次安装或通用模块升级时创建其余记分项
execute unless score #version ct_ctx matches 1.. run function cardtable:system/install
execute if score #version ct_ctx matches 1 run function cardtable:system/upgrade_v2
execute if score #version ct_ctx matches 2 run function cardtable:system/upgrade_v3

# 当前注册3个游戏；编号必须从1连续排列
scoreboard players set #game_count ct_ctx 3

# 重载时升级已加载牌桌；尚未加载的牌桌会由低频维护逻辑补做
execute as @e[type=minecraft:marker,tag=ct.controller] at @s unless data entity @s {data:{cardtable:{menu_version:12}}} run function cardtable:table/migrate_v12

# 立即修复重载前已经存在的牌桌与游戏文本，避免必须重建牌桌才能获得方块遮挡
function cardtable:display/repair_occlusion

tellraw @a[tag=ct.player] [{text:'[牌桌] ',color:'dark_aqua'},{text:'通用牌桌模块已重新加载。',color:'yellow'}]
