# take 已确认真实牌到账；不改变逻辑输入 #seat/#draw_idx 或 un.selected。
execute unless data entity @s data.uno.deal_queue run data modify entity @s data.uno.deal_queue set value []
execute store result storage uno:animation pending.seat int 1 run scoreboard players get #seat un_ctx
execute store result storage uno:animation pending.idx int 1 run scoreboard players get #draw_idx un_ctx
function uno:animation/append with storage uno:animation pending
