# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score #panel_serial sp_ctx matches 99999.. run scoreboard players add #ui_load sp_ctx 1
execute unless score #panel_serial sp_ctx matches 1..99998 run scoreboard players set #panel_serial sp_ctx 1
scoreboard players add #panel_serial sp_ctx 1
scoreboard players operation @s sp_nonce = #panel_serial sp_ctx
scoreboard players operation @s sp_seen = @e[tag=sp.current,limit=1] sp_epoch
scoreboard players operation @s sp_ui_load = #ui_load sp_ctx
scoreboard players operation @s sp_ui_table = @s sp_table
scoreboard players operation #ui_base sp_ctx = @s sp_nonce
scoreboard players operation #ui_base sp_ctx *= #factor sp_ctx
scoreboard players set @s sp_action 0
scoreboard players enable @s sp_action
data modify storage splendor:ui buttons set value []
data modify storage splendor:ui detail set value {text:""}
data modify storage splendor:ui picture set value {text:""}
execute store result storage splendor:ui close int 1 run scoreboard players get #ui_base sp_ctx
function splendor:ui/summary
