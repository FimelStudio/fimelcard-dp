# 第三版停用below_name真牌，改用每位观察者独立可见的Bossbar
scoreboard objectives setdisplay below_name
scoreboard players reset @a[tag=hb.player] hb_head
scoreboard players set #version hb_ctx 3
