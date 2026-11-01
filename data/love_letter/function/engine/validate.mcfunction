# 只读验证，失败不消耗手牌、牌库或阶段。
scoreboard players set #ok ll_ctx 0
scoreboard players set #error ll_ctx 1
function love_letter:system/context
tag @e[tag=ll.engine_actor] remove ll.engine_actor
tag @e[tag=ll.engine_target] remove ll.engine_target
execute unless score @s ll_state matches 2 run return 0
execute unless score @s ll_anim matches 0 run return 0
execute as @e[tag=ll.board,scores={ll_alive=1}] if score @s ll_seat = #actor ll_ctx run tag @s add ll.engine_actor
execute unless entity @e[tag=ll.engine_actor] run return 0
scoreboard players set #valid ll_ctx 1
