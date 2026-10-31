# epoch*100 + 动作。回合、阶段或重载变化后，旧窗口不能提交操作。
scoreboard players operation @s ch_ui_tmp = @s ch_action
scoreboard players set @s ch_action 0
scoreboard players enable @s ch_action
function chess:input/context
execute unless entity @s[tag=ch.actor] run return run function chess:input/invalid
execute unless score @s ch_ui_load = #ui_load ch_ctx run return run function chess:input/invalid
scoreboard players set #ui_100 ch_ctx 100
scoreboard players operation #ui_epoch ch_ctx = @s ch_ui_tmp
scoreboard players operation #ui_epoch ch_ctx /= #ui_100 ch_ctx
execute unless score #ui_epoch ch_ctx = @s ch_seen run return run function chess:input/invalid
execute unless score #ui_epoch ch_ctx = @e[tag=ch.current,limit=1] ch_epoch run return run function chess:input/invalid
scoreboard players operation #ui_action ch_ctx = @s ch_ui_tmp
scoreboard players operation #ui_action ch_ctx %= #ui_100 ch_ctx
execute unless score #ui_action ch_ctx matches 1..9 unless score #ui_action ch_ctx matches 10..13 run return run function chess:input/invalid
execute if score #ui_action ch_ctx matches 1 unless entity @e[tag=ch.current,scores={ch_state=1..3},limit=1] run return run function chess:input/invalid
execute if score #ui_action ch_ctx matches 9 unless entity @e[tag=ch.current,scores={ch_state=1..3},limit=1] run return run function chess:input/invalid
execute if score #ui_action ch_ctx matches 2..8 unless entity @e[tag=ch.current,scores={ch_state=1},limit=1] run return run function chess:input/invalid
execute if score #ui_action ch_ctx matches 10..13 unless entity @e[tag=ch.current,scores={ch_state=3},limit=1] run return run function chess:input/invalid
execute if score #ui_action ch_ctx matches 10..13 unless score @s ch_side = @e[tag=ch.current,limit=1] ch_turn run return run function chess:input/invalid
execute if score #ui_action ch_ctx matches 1 as @e[tag=ch.current,limit=1] at @s run function chess:game/resign
execute if score #ui_action ch_ctx matches 2 as @e[tag=ch.current,limit=1] at @s run function chess:game/offer_draw
execute if score #ui_action ch_ctx matches 3 as @e[tag=ch.current,limit=1] at @s run function chess:game/accept_draw
execute if score #ui_action ch_ctx matches 4 as @e[tag=ch.current,limit=1] at @s run function chess:game/decline_draw
execute if score #ui_action ch_ctx matches 5 if entity @e[tag=ch.current,scores={ch_state=1},limit=1] as @e[tag=ch.current,limit=1] at @s run function chess:game/claim_draw
execute if score #ui_action ch_ctx matches 6 as @e[tag=ch.current,limit=1] at @s run function chess:game/offer_undo
execute if score #ui_action ch_ctx matches 7 as @e[tag=ch.current,limit=1] at @s run function chess:game/accept_undo
execute if score #ui_action ch_ctx matches 8 as @e[tag=ch.current,limit=1] at @s run function chess:game/decline_undo
execute if score #ui_action ch_ctx matches 9 run function chess:ui/resign
scoreboard players set #promo ch_ctx 0
execute if score #ui_action ch_ctx matches 10 run scoreboard players set #promo ch_ctx 5
execute if score #ui_action ch_ctx matches 11 run scoreboard players set #promo ch_ctx 4
execute if score #ui_action ch_ctx matches 12 run scoreboard players set #promo ch_ctx 3
execute if score #ui_action ch_ctx matches 13 run scoreboard players set #promo ch_ctx 2
execute if score #promo ch_ctx matches 2..5 as @e[tag=ch.current,limit=1] at @s run function chess:game/promote
tag @a[tag=ch.actor] remove ch.actor
