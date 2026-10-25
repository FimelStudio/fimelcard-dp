scoreboard objectives add ab_goal dummy
scoreboard objectives add ab_settings trigger
scoreboard objectives add ab_set_table dummy
scoreboard players reset * ab_settings
scoreboard players reset * ab_set_table
execute as @e[tag=ct.controller] run function abraca:settings/init
# 出包魔法师（2至5人）：真实手牌保存在后台，Q键操作牌使用现有咒语牌面。
scoreboard objectives add ab_ctx dummy
function abraca:title/ensure_library
# 移除旧版本遗留的桌面咒语选择按钮。
kill @e[tag=ab.action_button]
execute unless score #version ab_ctx matches 1.. run function abraca:system/install
execute if score #version ab_ctx matches 1 run function abraca:system/upgrade_v2
execute if score #version ab_ctx matches 2 run function abraca:system/upgrade_v3
execute if score #version ab_ctx matches 3 run function abraca:system/upgrade_v4
execute if score #version ab_ctx matches 4 run function abraca:system/upgrade_v5
execute if score #version ab_ctx matches 5 run function abraca:system/upgrade_v6

# 升级移除旧物品牌背，真实手牌marker保持不变。
execute as @a[tag=ab.player] run function abraca:input/clear_tools
execute as @e[type=minecraft:item] if items entity @s contents minecraft:paper[minecraft:custom_data~{abraca:{stone:1b}}] run kill @s
tellraw @a[tag=ab.player] [{text:'[出包魔法师] ',color:'dark_purple'},{text:'数据包已重新加载，当前对局已保留。',color:'yellow'}]
execute as @e[type=minecraft:marker,tag=ab.controller] at @s run function abraca:game/resume
