# 创建安装标记所用的基础记分项；重复加载时仅这一行可能提示已存在
scoreboard objectives add fc_ctx dummy

# 首次安装创建全部记分项；旧版只执行增量升级，不重置牌桌编号
execute unless score #version fc_ctx matches 1.. run function fast_card:system/install
execute if score #version fc_ctx matches 1 run function fast_card:system/upgrade_v2
execute if score #version fc_ctx matches 2 run function fast_card:system/upgrade_v3
execute if score #version fc_ctx matches 3 run function fast_card:system/upgrade_v4
execute if score #version fc_ctx matches 4 run function fast_card:system/upgrade_v5

tellraw @a[tag=fc.player] [{text:'[Fast Card] ',color:'gold'},{text:'数据包已重新加载，正在恢复当前牌局。',color:'yellow'}]
