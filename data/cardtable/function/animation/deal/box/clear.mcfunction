# 只清除当前牌桌编号对应的公共牌盒，支持多桌同时发牌
scoreboard players operation #ctx_id ct_ctx = @s ct_id
execute as @e[type=minecraft:item_display,tag=ct.deal_box,distance=..2.1] if score @s ct_id = #ctx_id ct_ctx run kill @s
