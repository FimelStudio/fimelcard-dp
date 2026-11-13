# 第四版：为26.2的Q键纸牌丢弃事件增加短暂重试，兼容已创建的旧存档
scoreboard objectives add lh_drop_retry dummy
scoreboard players set @a lh_drop_retry 0
scoreboard players set #version lh_ctx 4
