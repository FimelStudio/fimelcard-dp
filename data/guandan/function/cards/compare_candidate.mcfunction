# 比较临时 #kind/#size/#high/#power，不读花色；同牌同点不能盖。
scoreboard players set #beats gd_ctx 0
execute unless score @s gd_lastkind matches 1..10 run return run scoreboard players set #beats gd_ctx 1
execute if score #power gd_ctx > @s gd_lastpow run return run scoreboard players set #beats gd_ctx 1
execute unless score #power gd_ctx = @s gd_lastpow run return 0
execute unless score #kind gd_ctx = @s gd_lastkind run return 0
execute unless score #size gd_ctx = @s gd_lastsize run return 0
execute if score #high gd_ctx > @s gd_lasthi run scoreboard players set #beats gd_ctx 1
