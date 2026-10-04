# 执行者为本桌控制器；ab.actor是提交动作的玩家。
execute unless entity @a[tag=ab.actor,tag=ab.turn,limit=1] run return 0
scoreboard players operation #spell ab_ctx = @a[tag=ab.actor,limit=1] ab_action
execute unless score #spell ab_ctx matches 1..8 run tellraw @a[tag=ab.actor,limit=1] [{text:'[出包魔法师] ',color:'dark_purple'},{text:'请选择1至8号咒语。',color:'red'}]
execute unless score #spell ab_ctx matches 1..8 run return 0
execute store result storage abraca:debug id int 1 run scoreboard players get @s ab_id
execute store result storage abraca:debug seat int 1 run scoreboard players get @a[tag=ab.actor,limit=1] ab_seat
execute store result storage abraca:debug spell int 1 run scoreboard players get #spell ab_ctx
function abraca:debug/log_cast with storage abraca:debug
execute if score @a[tag=ab.actor,limit=1] ab_last > #spell ab_ctx run function abraca:action/fail_order
# 失败若使玩家倒地，round_finish会直接创建新局并把ab_state切到发牌状态；此时必须终止上一局的施法链。
execute unless score @s ab_state matches 2 run return 0
execute if score @a[tag=ab.actor,limit=1] ab_last > #spell ab_ctx run return 0
scoreboard players operation #ctx ab_ctx = @s ab_id
scoreboard players operation #seat ab_ctx = @a[tag=ab.actor,limit=1] ab_seat
tag @e[tag=ab.chosen] remove ab.chosen
execute as @e[type=minecraft:marker,tag=ab.hand] if score @s ab_id = #ctx ab_ctx if score @s ab_owner = #seat ab_ctx if score @s ab_spell = #spell ab_ctx run tag @s add ab.chosen
execute unless entity @e[tag=ab.chosen,limit=1] run function abraca:action/fail
# 缺牌失败完成后无论是否触发换局，都不能继续落入后面的成功施法分支。
execute unless entity @e[tag=ab.chosen,limit=1] run return 0
execute if entity @e[tag=ab.chosen,limit=1] run function abraca:action/success
