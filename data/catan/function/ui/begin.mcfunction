execute if score #panel_serial ca_ctx matches 99999.. run scoreboard players add #ui_load ca_ctx 1
execute unless score #panel_serial ca_ctx matches 1..99998 run scoreboard players set #panel_serial ca_ctx 1
scoreboard players add #panel_serial ca_ctx 1
scoreboard players operation @s ca_nonce = #panel_serial ca_ctx
scoreboard players operation @s ca_seen = @e[tag=ca.current,limit=1] ca_epoch
scoreboard players operation @s ca_ui_load = #ui_load ca_ctx
scoreboard players operation @s ca_ui_table = @s ca_table
scoreboard players operation #ui_base ca_ctx = @s ca_nonce
scoreboard players operation #ui_base ca_ctx *= #factor ca_ctx
data modify storage catan:ui buttons set value []
scoreboard players set @s ca_action 0
scoreboard players enable @s ca_action
scoreboard players set @s ca_panel 0
function catan:ui/summary
