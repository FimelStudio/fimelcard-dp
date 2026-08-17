# 第三版加入通用动画实体计时项
scoreboard objectives add ct_anim dummy
scoreboard players set #version ct_ctx 3

tellraw @a [{text:'[牌桌] ',color:'dark_aqua'},{text:'已安装通用发牌动画模块。',color:'green'}]
