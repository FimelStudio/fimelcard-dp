execute if score #panel_serial go_ctx matches 9999.. run scoreboard players add #ui_load go_ctx 1
execute unless score #panel_serial go_ctx matches 0..9998 run scoreboard players set #panel_serial go_ctx 0
scoreboard players add #panel_serial go_ctx 1
scoreboard players operation @s go_ui_serial = #panel_serial go_ctx
scoreboard players operation @s go_seen = @e[tag=go.current,limit=1] go_epoch
scoreboard players operation @s go_ui_load = #ui_load go_ctx
scoreboard players operation @s go_ui_table = @s go_table
scoreboard players operation #ui_base go_ctx = @s go_ui_serial
scoreboard players set #ui_factor go_ctx 10000
scoreboard players operation #ui_base go_ctx *= #ui_factor go_ctx
data modify storage weiqi:ui buttons set value []
scoreboard players set @s go_action 0
scoreboard players enable @s go_action
function weiqi:ui/summary
