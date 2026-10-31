# epoch*100 + 动作。回合、阶段或重载变化后，旧窗口不能提交操作。
scoreboard players operation @s xq_ui_tmp = @s xq_action
scoreboard players set @s xq_action 0
scoreboard players enable @s xq_action
function xiangqi:input/context
execute unless entity @s[tag=xq.actor] run return run function xiangqi:input/invalid
execute unless score @s xq_ui_load = #ui_load xq_ctx run return run function xiangqi:input/invalid
scoreboard players set #ui_100 xq_ctx 100
scoreboard players operation #ui_epoch xq_ctx = @s xq_ui_tmp
scoreboard players operation #ui_epoch xq_ctx /= #ui_100 xq_ctx
execute unless score #ui_epoch xq_ctx = @s xq_seen run return run function xiangqi:input/invalid
execute unless score #ui_epoch xq_ctx = @e[tag=xq.current,limit=1] xq_epoch run return run function xiangqi:input/invalid
scoreboard players operation #ui_action xq_ctx = @s xq_ui_tmp
scoreboard players operation #ui_action xq_ctx %= #ui_100 xq_ctx
execute unless score #ui_action xq_ctx matches 1..9 run return run function xiangqi:input/invalid
execute if score #ui_action xq_ctx matches 5 run return run function xiangqi:input/invalid
execute if score #ui_action xq_ctx matches 1 unless entity @e[tag=xq.current,scores={xq_state=1..2},limit=1] run return run function xiangqi:input/invalid
execute if score #ui_action xq_ctx matches 9 unless entity @e[tag=xq.current,scores={xq_state=1..2},limit=1] run return run function xiangqi:input/invalid
execute if score #ui_action xq_ctx matches 2..8 unless entity @e[tag=xq.current,scores={xq_state=1},limit=1] run return run function xiangqi:input/invalid
execute if score #ui_action xq_ctx matches 1 as @e[tag=xq.current,limit=1] at @s run function xiangqi:game/resign
execute if score #ui_action xq_ctx matches 2 as @e[tag=xq.current,limit=1] at @s run function xiangqi:game/offer_draw
execute if score #ui_action xq_ctx matches 3 as @e[tag=xq.current,limit=1] at @s run function xiangqi:game/accept_draw
execute if score #ui_action xq_ctx matches 4 as @e[tag=xq.current,limit=1] at @s run function xiangqi:game/decline_draw
execute if score #ui_action xq_ctx matches 6 as @e[tag=xq.current,limit=1] at @s run function xiangqi:game/offer_undo
execute if score #ui_action xq_ctx matches 7 as @e[tag=xq.current,limit=1] at @s run function xiangqi:game/accept_undo
execute if score #ui_action xq_ctx matches 8 as @e[tag=xq.current,limit=1] at @s run function xiangqi:game/decline_undo
execute if score #ui_action xq_ctx matches 9 run function xiangqi:ui/resign
tag @a[tag=xq.actor] remove xq.actor
