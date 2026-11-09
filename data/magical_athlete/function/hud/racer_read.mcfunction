$data modify storage magical_athlete:hud racer set from entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[$(index)]
data modify storage magical_athlete:hud racer.state set value ""
execute if data storage magical_athlete:hud racer{trip:1} run data modify storage magical_athlete:hud racer.state set value "（绊倒）"
execute if data storage magical_athlete:hud racer{status:1} run data modify storage magical_athlete:hud racer.state set value "（到达）"
execute if data storage magical_athlete:hud racer{status:2} run data modify storage magical_athlete:hud racer.state set value "（出局）"
function magical_athlete:hud/racer_name with storage magical_athlete:hud racer
function magical_athlete:hud/racer_text with storage magical_athlete:hud racer
