# epoch*100 + 动作。回合、阶段或重载变化后，旧窗口不能提交操作。
scoreboard players operation @s gm_ui_tmp = @s gm_action
scoreboard players set @s gm_action 0
scoreboard players enable @s gm_action
function gomoku:input/context
execute unless entity @s[tag=gm.actor] run return run function gomoku:input/invalid
execute unless score @s gm_ui_load = #ui_load gm_ctx run return run function gomoku:input/invalid
scoreboard players set #ui_100 gm_ctx 100
scoreboard players operation #ui_epoch gm_ctx = @s gm_ui_tmp
scoreboard players operation #ui_epoch gm_ctx /= #ui_100 gm_ctx
execute unless score #ui_epoch gm_ctx = @s gm_seen run return run function gomoku:input/invalid
execute unless score #ui_epoch gm_ctx = @e[tag=gm.current,limit=1] gm_epoch run return run function gomoku:input/invalid
scoreboard players operation #ui_action gm_ctx = @s gm_ui_tmp
scoreboard players operation #ui_action gm_ctx %= #ui_100 gm_ctx
execute unless score #ui_action gm_ctx matches 1..10 run return run function gomoku:input/invalid
execute if score #ui_action gm_ctx matches 5 run return run function gomoku:input/invalid
execute if score #ui_action gm_ctx matches 1 unless entity @e[tag=gm.current,scores={gm_state=1..2},limit=1] run return run function gomoku:input/invalid
execute if score #ui_action gm_ctx matches 9 unless entity @e[tag=gm.current,scores={gm_state=1..2},limit=1] run return run function gomoku:input/invalid
execute if score #ui_action gm_ctx matches 2..8 unless entity @e[tag=gm.current,scores={gm_state=1},limit=1] run return run function gomoku:input/invalid
execute if score #ui_action gm_ctx matches 1 as @e[tag=gm.current,limit=1] at @s run function gomoku:game/resign
execute if score #ui_action gm_ctx matches 2 as @e[tag=gm.current,limit=1] at @s run function gomoku:game/offer_draw
execute if score #ui_action gm_ctx matches 3 as @e[tag=gm.current,limit=1] at @s run function gomoku:game/accept_draw
execute if score #ui_action gm_ctx matches 4 as @e[tag=gm.current,limit=1] at @s run function gomoku:game/decline_draw
execute if score #ui_action gm_ctx matches 6 as @e[tag=gm.current,limit=1] at @s run function gomoku:game/offer_undo
execute if score #ui_action gm_ctx matches 7 as @e[tag=gm.current,limit=1] at @s run function gomoku:game/accept_undo
execute if score #ui_action gm_ctx matches 8 as @e[tag=gm.current,limit=1] at @s run function gomoku:game/decline_undo
execute if score #ui_action gm_ctx matches 9 run function gomoku:ui/resign
execute if score #ui_action gm_ctx matches 10 run function gomoku:ui/coordinates
tag @a[tag=gm.actor] remove gm.actor
