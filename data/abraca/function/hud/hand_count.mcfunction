# 玩家执行：按桌号和实际座号统计真实手牌，不计操作牌、牌库、秘密石或已施放石。
scoreboard players operation #hud_table ab_ctx = @s ab_id
scoreboard players operation #hud_seat ab_ctx = @s ab_seat
scoreboard players set #hud_hand ab_ctx 0
execute as @e[type=minecraft:marker,tag=ab.hand] if score @s ab_id = #hud_table ab_ctx if score @s ab_owner = #hud_seat ab_ctx run scoreboard players add #hud_hand ab_ctx 1
