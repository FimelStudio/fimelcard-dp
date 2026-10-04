scoreboard players add @s sk_deal_time 1
execute if score @s sk_deal_time matches 1 run function cardtable:animation/deal/box/grow
# 每座4张、每张4刻；八座扫描包含空位，避免漏掉高号座。
execute unless score @s ct_capacity matches 8 if score @s sk_deal_time matches 12..75 run function skull:deal/check
execute unless score @s ct_capacity matches 8 if score @s sk_deal_time matches 76 run function cardtable:animation/deal/box/shrink
execute unless score @s ct_capacity matches 8 if score @s sk_deal_time matches 87.. run function skull:deal/complete
execute if score @s ct_capacity matches 8 if score @s sk_deal_time matches 12..139 run function skull:deal/check
execute if score @s ct_capacity matches 8 if score @s sk_deal_time matches 140 run function cardtable:animation/deal/box/shrink
execute if score @s ct_capacity matches 8 if score @s sk_deal_time matches 151.. run function skull:deal/complete
