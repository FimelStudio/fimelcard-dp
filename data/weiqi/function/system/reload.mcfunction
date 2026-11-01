tag @s add go.controller
execute if score @s ct_state matches 0 run function weiqi:game/init_table
execute if score @s ct_state matches 0 run return run function weiqi:game/restore_review_tools
function weiqi:system/context
scoreboard players add @s go_epoch 1
function weiqi:ai/reset
function weiqi:game/reseat
# 动画被重载截断时直接完成，不重走一次、也不重置时钟。
execute if score @s go_state matches 2 run scoreboard players set @s go_state 1
function weiqi:visual/refresh
execute if score @s go_state matches 3 run function weiqi:engine/score
execute if score @s go_state matches 3 run function weiqi:visual/estimate
execute if score @s go_state matches 1 if entity @a[tag=go.audience,scores={go_view=1}] run function weiqi:engine/estimate
execute if score @s go_state matches 1 if entity @a[tag=go.audience,scores={go_view=1}] run function weiqi:visual/estimate
function weiqi:clock/create
execute as @a[tag=go.audience] run function weiqi:input/give
function weiqi:ui/refresh
