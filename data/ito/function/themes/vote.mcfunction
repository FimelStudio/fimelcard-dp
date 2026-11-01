execute unless score @e[tag=it.current,limit=1] it_state matches 1 run return 0
scoreboard players operation @s it_vote = #choice it_ctx
tellraw @s {"text":"[命悬一线] 选题票已记录，等待其他玩家；可重新打开改票。","color":"green"}
execute as @e[tag=it.current,limit=1] at @s run function ito:themes/check
