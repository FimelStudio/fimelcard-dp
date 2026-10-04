# 第四版新增桌型容量；旧桌容量由实例迁移补为4，不重置进行中的游戏。
scoreboard objectives add ct_capacity dummy
scoreboard players set #version ct_ctx 4
