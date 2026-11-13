# 保留结算用的有符号净分。聊天用队名和正分。
data modify storage doudizhu:ui side_text set value {text:"流局 0",color:"gray"}
execute if score @s dd_side_score matches 0 run return 0
data modify storage doudizhu:ui side_args set value {team:"红队",color:"red"}
scoreboard players operation #side_display dd_ctx = @s dd_side_score
scoreboard players set #side_negate dd_ctx -1
execute if score @s dd_side_score matches ..-1 run data modify storage doudizhu:ui side_args set value {team:"蓝队",color:"blue"}
execute if score @s dd_side_score matches ..-1 run scoreboard players operation #side_display dd_ctx *= #side_negate dd_ctx
execute store result storage doudizhu:ui side_args.points int 1 run scoreboard players get #side_display dd_ctx
function doudizhu:duplicate/side_text with storage doudizhu:ui side_args
