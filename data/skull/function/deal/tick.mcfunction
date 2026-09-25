scoreboard players add @s sk_deal_time 1
execute if score @s sk_deal_time matches 1 run function cardtable:animation/deal/box/grow
execute if score @s sk_deal_time matches 12..75 run function skull:deal/check
execute if score @s sk_deal_time matches 76 run function cardtable:animation/deal/box/shrink
execute if score @s sk_deal_time matches 87.. run function skull:deal/complete
