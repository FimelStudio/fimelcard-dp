# 面板独立nonce防同一回合重开窗口后复用旧按钮，epoch防回合/点目变化。
scoreboard players operation @s go_ui_tmp = @s go_action
scoreboard players set @s go_action 0
scoreboard players enable @s go_action
function weiqi:input/context
execute unless entity @s[tag=go.actor] run return run function weiqi:input/invalid
execute unless score @s go_ui_load = #ui_load go_ctx run return run function weiqi:input/invalid
execute unless score @s go_ui_table = @s go_table run return run function weiqi:input/invalid
execute unless score @s go_seen = @e[tag=go.current,limit=1] go_epoch run return run function weiqi:input/invalid
scoreboard players set #ui_factor go_ctx 10000
scoreboard players operation #ui_serial go_ctx = @s go_ui_tmp
scoreboard players operation #ui_serial go_ctx /= #ui_factor go_ctx
execute unless score #ui_serial go_ctx = @s go_ui_serial run return run function weiqi:input/invalid
scoreboard players operation #ui_action go_ctx = @s go_ui_tmp
scoreboard players operation #ui_action go_ctx %= #ui_factor go_ctx
scoreboard players set #ui_valid go_ctx 0
execute if score #ui_action go_ctx matches 10 run scoreboard players set #ui_valid go_ctx 1
execute if score #ui_action go_ctx matches 11 run scoreboard players set #ui_valid go_ctx 1
execute if score #ui_action go_ctx matches 20 run scoreboard players set #ui_valid go_ctx 1
execute if score #ui_action go_ctx matches 21 run scoreboard players set #ui_valid go_ctx 1
execute if score #ui_action go_ctx matches 22 run scoreboard players set #ui_valid go_ctx 1
execute if score #ui_action go_ctx matches 30 run scoreboard players set #ui_valid go_ctx 1
execute if score #ui_action go_ctx matches 31 run scoreboard players set #ui_valid go_ctx 1
execute if score #ui_action go_ctx matches 40 run scoreboard players set #ui_valid go_ctx 1
execute if score #ui_action go_ctx matches 41 run scoreboard players set #ui_valid go_ctx 1
execute if score #ui_action go_ctx matches 50 run scoreboard players set #ui_valid go_ctx 1
execute if score #ui_action go_ctx matches 60 run scoreboard players set #ui_valid go_ctx 1
execute if score #ui_action go_ctx matches 61 run scoreboard players set #ui_valid go_ctx 1
execute if score #ui_action go_ctx matches 62 run scoreboard players set #ui_valid go_ctx 1
execute if score #ui_action go_ctx matches 63 run scoreboard players set #ui_valid go_ctx 1
execute if score #ui_action go_ctx matches 64 run scoreboard players set #ui_valid go_ctx 1
execute if score #ui_action go_ctx matches 65 run scoreboard players set #ui_valid go_ctx 1
execute if score #ui_action go_ctx matches 66 run scoreboard players set #ui_valid go_ctx 1
execute if score #ui_action go_ctx matches 70 run scoreboard players set #ui_valid go_ctx 1
execute unless score #ui_valid go_ctx matches 1 run return run function weiqi:input/invalid
execute if score #ui_action go_ctx matches 10 as @e[tag=go.current,limit=1] at @s run function weiqi:game/pass
execute if score #ui_action go_ctx matches 11 as @e[tag=go.current,limit=1] at @s run function weiqi:game/estimate
execute if score #ui_action go_ctx matches 20 as @e[tag=go.current,limit=1] at @s run function weiqi:game/request_undo
execute if score #ui_action go_ctx matches 21 as @e[tag=go.current,limit=1] at @s run function weiqi:game/accept_undo
execute if score #ui_action go_ctx matches 22 as @e[tag=go.current,limit=1] at @s run function weiqi:game/reject_undo
execute if score #ui_action go_ctx matches 30 run return run function weiqi:ui/resign
execute if score #ui_action go_ctx matches 31 as @e[tag=go.current,limit=1] at @s run function weiqi:game/resign
execute if score #ui_action go_ctx matches 40 as @e[tag=go.current,limit=1] at @s run function weiqi:game/confirm_score
execute if score #ui_action go_ctx matches 41 as @e[tag=go.current,limit=1] at @s run function weiqi:game/resume
execute if score #ui_action go_ctx matches 50 run return run function weiqi:ui/coordinates
execute if score #ui_action go_ctx matches 60 as @e[tag=go.current,limit=1] at @s run function weiqi:game/review_open
execute if score #ui_action go_ctx matches 61 as @e[tag=go.current,limit=1] at @s run function weiqi:game/review_close
execute if score #ui_action go_ctx matches 62 as @e[tag=go.current,limit=1] at @s run function weiqi:game/review_prev
execute if score #ui_action go_ctx matches 63 as @e[tag=go.current,limit=1] at @s run function weiqi:game/review_next
execute if score #ui_action go_ctx matches 64 as @e[tag=go.current,limit=1] at @s run function weiqi:game/review_first
execute if score #ui_action go_ctx matches 65 as @e[tag=go.current,limit=1] at @s run function weiqi:game/review_last
execute if score #ui_action go_ctx matches 66 as @e[tag=go.current,limit=1] at @s run function weiqi:game/review_play
execute if score #ui_action go_ctx matches 70 run return run function weiqi:rules/player
execute if entity @s[tag=go.actor] run function weiqi:ui/open
tag @a[tag=go.actor] remove go.actor
