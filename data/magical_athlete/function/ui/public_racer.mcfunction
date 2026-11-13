# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage magical_athlete:ui racer set from entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[$(index)]
execute if data storage magical_athlete:ui racer{char:-1} run return 0
execute if data storage magical_athlete:ui racer{owner:0} run return 0
function magical_athlete:ui/public_racer_data with storage magical_athlete:ui racer
