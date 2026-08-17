# 创建安装标记所用的基础记分项
scoreboard objectives add lh_ctx dummy

# 首次安装创建全部记分项，旧存档再按版本逐级升级
execute unless score #version lh_ctx matches 1.. run function liars_holdem:system/install
execute if score #version lh_ctx matches 1 run function liars_holdem:system/upgrade_v2
execute if score #version lh_ctx matches 2 run function liars_holdem:system/upgrade_v3
execute if score #version lh_ctx matches 3 run function liars_holdem:system/upgrade_v4
scoreboard players set #two lh_ctx 2
scoreboard players set #twenty lh_ctx 20
scoreboard players set #base lh_ctx 15

# 删除上一版遗留的未注册公共牌实体；正常公共牌已在生成时移除该临时data
kill @e[type=minecraft:item_display,nbt={data:{liars_holdem:{new_community:1b}}}]
# 旧版子弹通过临时data反查实体，异常中断时可能留下未注册实体；新版不再使用该标记
kill @e[type=minecraft:item_display,nbt={data:{liars_holdem:{new_bullet:1b}}}]

tellraw @a[tag=lh.player] [{text:'[赌命德州扑克] ',color:'red'},{text:'数据包已重新加载，正在恢复当前牌局。',color:'yellow'}]
