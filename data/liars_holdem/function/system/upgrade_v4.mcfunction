# 第四版：为26.2的Q键纸牌丢弃事件增加短暂重试，兼容已创建的旧存档
scoreboard objectives add lh_drop_retry dummy
scoreboard players set @a lh_drop_retry 0
scoreboard players set #version lh_ctx 4
tellraw @a[tag=lh.player] [{text:'[赌命德州扑克] ',color:'red'},{text:'Q键换牌检测已升级。',color:'green'}]
