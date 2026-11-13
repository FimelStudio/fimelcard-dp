function weiqi:game/actor_guard
execute unless score #actor_ok go_ctx matches 1 run return 0
execute unless score @s go_state matches 1..3 run return 0
execute unless score @s go_estimate matches 1 run return 0
scoreboard players add @a[tag=go.actor,limit=1] go_view 1
execute if score @a[tag=go.actor,limit=1] go_view matches 2.. run scoreboard players set @a[tag=go.actor,limit=1] go_view 0
execute if score @s go_state matches 3 run return run function weiqi:game/scoring_overlay
execute if entity @a[tag=go.audience,scores={go_view=1}] run function weiqi:engine/estimate
execute if entity @a[tag=go.audience,scores={go_view=1}] run function weiqi:visual/estimate
execute unless entity @a[tag=go.audience,scores={go_view=1}] run function weiqi:visual/clear_estimate
tellraw @a[tag=go.actor] {"text": "[围棋] 占地为局部影响的保守估算，未判定死活，未定点不计；标记同步显示在本桌棋盘。", "color": "gray"}
function weiqi:ui/refresh
