execute if score #spell ab_ctx matches 1 run function abraca:action/fail_dragon
# 古代巨龙反噬若使玩家倒地，会在子函数内直接开始新局；牌库重建会复用#spell，必须先按游戏状态截断旧流程。
execute unless score @s ab_state matches 2 run return 0
execute if score #spell ab_ctx matches 1 run return 0
execute store result storage abraca:debug id int 1 run scoreboard players get @s ab_id
execute store result storage abraca:debug seat int 1 run scoreboard players get @a[tag=ab.actor,limit=1] ab_seat
execute store result storage abraca:debug spell int 1 run scoreboard players get #spell ab_ctx
function abraca:debug/log_fail with storage abraca:debug
function abraca:message/fail
scoreboard players remove @a[tag=ab.actor,limit=1] ab_hp 1
function abraca:hud/update
function abraca:turn/end
