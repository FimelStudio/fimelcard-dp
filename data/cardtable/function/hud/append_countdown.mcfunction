# 将剩余游戏刻向上取整为秒，供姓名栏排版。
scoreboard players add #hud_ticks ct_ctx 19
scoreboard players set #hud_ticks_per_second ct_ctx 20
scoreboard players operation #hud_ticks ct_ctx /= #hud_ticks_per_second ct_ctx
execute store result storage cardtable:hud seconds int 1 run scoreboard players get #hud_ticks ct_ctx
function cardtable:hud/countdown_text with storage cardtable:hud
