# 第二版加入玩家在线心跳；在线玩家从当前刻开始记录，离线旧会话会在其返回时清理
scoreboard objectives add ct_online dummy
scoreboard players set @a[tag=ct.player] ct_online 1
scoreboard players set #version ct_ctx 2
