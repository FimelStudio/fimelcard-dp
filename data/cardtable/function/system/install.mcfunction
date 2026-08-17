# 牌桌、玩家和交互实体共享的实例数据
scoreboard objectives add ct_id dummy
scoreboard objectives add ct_state dummy
scoreboard objectives add ct_game dummy
scoreboard objectives add ct_kind dummy
scoreboard objectives add ct_seat dummy
scoreboard objectives add ct_joined dummy
scoreboard objectives add ct_online dummy
scoreboard objectives add ct_anim dummy

# 开始流程和结束投票
scoreboard objectives add ct_start dummy
scoreboard objectives add ct_votes dummy
scoreboard objectives add ct_voted dummy

# 持久化系统值
scoreboard players set #next_id ct_ctx 0
scoreboard players set #clock ct_ctx 0
scoreboard players set #game_count ct_ctx 1
scoreboard players set @a[tag=ct.player] ct_online 1
scoreboard players set #version ct_ctx 3

tellraw @a [{text:'[牌桌] ',color:'dark_aqua'},{text:'通用牌桌模块安装完成。',color:'green'}]
