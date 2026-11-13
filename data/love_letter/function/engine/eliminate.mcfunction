# 淘汰公开弃掉剩余牌；公主、间谍等弃牌均不发动技能。
execute unless score @s ll_alive matches 1 run return 0
scoreboard players set @s ll_alive 0
scoreboard players operation #discard ll_ctx = @s ll_hand
function love_letter:engine/discard
scoreboard players operation #discard ll_ctx = @s ll_extra
function love_letter:engine/discard
scoreboard players set @s ll_hand -1
scoreboard players set @s ll_extra -1
scoreboard players set @s ll_protect 0
execute store result storage love_letter:runtime seat int 1 run scoreboard players get @s ll_seat
data modify entity @e[tag=ll.current,limit=1] data.love_letter.action.eliminated append from storage love_letter:runtime seat
