# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function magical_athlete:input/context
execute unless entity @s[tag=ma.actor] run return 0
scoreboard players set @s ma_depoch -1
function magical_athlete:direct/sync
execute if score @s ma_side = @e[tag=ma.current,limit=1] ma_pending if data entity @e[tag=ma.current,limit=1] data.magical_athlete.pending{kind:"twin"} run return run function magical_athlete:direct/special
function magical_athlete:hud/notice {"text":{"text":"右键桌面选择；角色与技能选项手持按Q，骰子按Q投骰。","color":"yellow"}}
