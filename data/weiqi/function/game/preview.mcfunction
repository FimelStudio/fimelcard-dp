execute unless score @s ct_game matches 20 run return 0
execute unless score @s ct_state matches 0 run return 0
execute if data entity @s data.weiqi{review:1b} run return run function weiqi:game/preserve_review
scoreboard players set @s go_state 0
scoreboard players set @s go_sel -1
scoreboard players set @s go_timer 0
scoreboard players set @s go_pulse 0
scoreboard players set @s go_bot 0
scoreboard players set @s go_undo 0
scoreboard players set @s go_autoplay 0
scoreboard players add @s go_epoch 1
function weiqi:ai/reset
function weiqi:visual/clear
function weiqi:system/create_board
function weiqi:engine/init_board
function weiqi:visual/setup
