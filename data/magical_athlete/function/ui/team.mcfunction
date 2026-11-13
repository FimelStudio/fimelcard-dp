# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage magical_athlete:ui team set from entity @e[tag=ma.current,limit=1] data.magical_athlete.p$(side)
function magical_athlete:ui/team_append with storage magical_athlete:ui team
