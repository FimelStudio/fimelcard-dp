# phase4 buffer[0] 是已有手牌的影像；它只能弃一次。phase5 已移除留牌，余下全归底。
execute if score @s ll_phase matches 4 run data remove entity @s data.ll_buffer[0]
execute if data entity @s data.ll_buffer[0] run data modify entity @s data.love_letter.deck append from entity @s data.ll_buffer[0]
execute if data entity @s data.ll_buffer[1] run data modify entity @s data.love_letter.deck append from entity @s data.ll_buffer[1]
data modify entity @s data.ll_buffer set value []
