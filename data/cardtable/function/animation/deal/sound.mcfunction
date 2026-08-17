# 向当前牌桌的所有玩家播放一次公共发牌音效
scoreboard players operation #ctx_id ct_ctx = @s ct_id
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id ct_ctx at @s run playsound minecraft:item.book.page_turn master @s ~ ~ ~ 0.35 1.35
