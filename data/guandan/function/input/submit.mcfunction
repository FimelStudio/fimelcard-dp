# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation @s gd_ui_tmp = @s gd_action
scoreboard players set @s gd_action 0
scoreboard players enable @s gd_action
function guandan:input/context
execute unless entity @s[tag=gd.actor] run return run function guandan:input/invalid
execute unless score @s gd_ui_load = #ui_load gd_ctx run return run function guandan:input/invalid
execute unless score @s gd_uiepoch = @e[tag=gd.current,limit=1] gd_epoch run return run function guandan:input/invalid
scoreboard players set #ui_factor gd_ctx 10000
scoreboard players operation #ui_nonce gd_ctx = @s gd_ui_tmp
scoreboard players operation #ui_nonce gd_ctx /= #ui_factor gd_ctx
execute unless score #ui_nonce gd_ctx = @s gd_seen run return run function guandan:input/invalid
scoreboard players operation #ui_action gd_ctx = @s gd_ui_tmp
scoreboard players operation #ui_action gd_ctx %= #ui_factor gd_ctx
execute if score #ui_action gd_ctx matches 1 run return run function guandan:ui/open
execute if score #ui_action gd_ctx matches 3 run return run function guandan:rules/player
execute if score #ui_action gd_ctx matches 20 run return run function guandan:input/play
execute if score #ui_action gd_ctx matches 21 run return run function guandan:input/pass
execute if score #ui_action gd_ctx matches 22 run return run function guandan:input/deselect
execute if score #ui_action gd_ctx matches 23 run return run function guandan:input/tribute
execute if score #ui_action gd_ctx matches 24 run return run function guandan:input/hint
execute if score #ui_action gd_ctx matches 100..207 run return run function guandan:input/select
execute if score #ui_action gd_ctx matches 1000..8999 run return run function guandan:input/choose
function guandan:input/invalid
