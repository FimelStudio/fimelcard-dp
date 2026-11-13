# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score #panel_serial ma_ctx matches 99999.. run scoreboard players add #ui_load ma_ctx 1
execute unless score #panel_serial ma_ctx matches 1..99998 run scoreboard players set #panel_serial ma_ctx 1
scoreboard players add #panel_serial ma_ctx 1
scoreboard players operation @s ma_nonce = #panel_serial ma_ctx
scoreboard players operation @s ma_seen = @e[tag=ma.current,limit=1] ma_epoch
scoreboard players operation @s ma_ui_load = #ui_load ma_ctx
scoreboard players operation @s ma_ui_table = @s ma_table
scoreboard players operation @s ma_ui_seat = @s ct_seat
scoreboard players operation #ui_base ma_ctx = @s ma_nonce
scoreboard players operation #ui_base ma_ctx *= #factor ma_ctx
scoreboard players set @s ma_action 0
scoreboard players enable @s ma_action
data modify storage magical_athlete:ui buttons set value []
data modify storage magical_athlete:ui detail set value {text:"",extra:[{text:""}]}
data modify storage magical_athlete:ui title set value "胡闹运动会 · 比赛菜单"
execute store result storage magical_athlete:ui close int 1 run scoreboard players get #ui_base ma_ctx
execute store result storage magical_athlete:ui side int 1 run scoreboard players get @s ma_side
function magical_athlete:ui/private with storage magical_athlete:ui
execute as @e[tag=ma.current,limit=1] run function magical_athlete:ui/summary with entity @s data.magical_athlete
