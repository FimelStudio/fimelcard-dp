# 第五版加入Fast Card设置对话框的普通玩家trigger保存通道
scoreboard objectives add fc_settings trigger
scoreboard objectives add fc_set_table dummy
scoreboard players set #version fc_ctx 5

tellraw @a [{text:'[Fast Card] ',color:'gold'},{text:'已升级设置对话框的trigger保存通道。',color:'green'}]
