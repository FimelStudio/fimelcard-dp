# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function catan:input/context
execute unless entity @s[tag=ca.actor] run return 0
function catan:direct/controls
function catan:hud/notice {"text":{"text":"建筑右键或Q；资源和发展卡在物品栏，交易使用交易物品。","color":"yellow"}}
