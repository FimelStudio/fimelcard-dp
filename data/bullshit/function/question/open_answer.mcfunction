# 执行者为玩家；只允许本人、本桌、阅读阶段访问。
execute unless entity @s[tag=bw.player] run return 0
execute unless score @s ct_id = @s bw_id run return 0
scoreboard players operation #ctx bw_ctx = @s bw_id
scoreboard players set #reading_valid bw_ctx 0
execute as @e[type=minecraft:marker,tag=bw.controller,scores={bw_state=1}] if score @s bw_id = #ctx bw_ctx run scoreboard players set #reading_valid bw_ctx 1
execute unless score #reading_valid bw_ctx matches 1 run return 0
function bullshit:input/give_reading
execute unless score @s bw_role matches 2 run return run function bullshit:question/waiting_dialog
execute as @e[type=minecraft:marker,tag=bw.controller,scores={bw_state=1}] if score @s bw_id = #ctx bw_ctx run function bullshit:question/answer_dialog
