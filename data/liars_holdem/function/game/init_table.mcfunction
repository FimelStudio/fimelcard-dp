# 当前执行者是牌桌控制器；本函数幂等且只校正本游戏持久设置
# 简陋开枪演出的默认等待时间为2秒，可在游戏设置中调整为1至5秒
execute unless score @s lh_gun_time matches 1..5 run scoreboard players set @s lh_gun_time 2
