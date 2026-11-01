scoreboard players operation #hud_seconds ll_ctx = @e[tag=ll.current,limit=1] ll_clock
scoreboard players add #hud_seconds ll_ctx 19
scoreboard players set #hud_twenty ll_ctx 20
scoreboard players operation #hud_seconds ll_ctx /= #hud_twenty ll_ctx
execute store result storage love_letter:hud seconds int 1 run scoreboard players get #hud_seconds ll_ctx
function love_letter:hud/clock_text with storage love_letter:hud
