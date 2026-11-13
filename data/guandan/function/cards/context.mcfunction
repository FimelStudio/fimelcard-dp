# 调用链内临时实体集合每次按桌号重建，不能依靠距离确定归属。
tag @e[tag=gd.cards] remove gd.cards
scoreboard players operation #card_table gd_ctx = @s ct_id
execute as @e[type=minecraft:marker,tag=gd.card] if score @s ct_id = #card_table gd_ctx run tag @s add gd.cards
scoreboard players operation #level gd_ctx = @s gd_level
