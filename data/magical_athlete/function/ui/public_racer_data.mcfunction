# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage magical_athlete:ui racer.name set from storage magical_athlete:characters chars[$(char)].name
$data modify storage magical_athlete:ui racer.ability set from storage magical_athlete:characters chars[$(char)].ability
$data modify storage magical_athlete:ui racer.owner_name set from entity @e[tag=ma.current,limit=1] data.magical_athlete.p$(owner).name
data modify storage magical_athlete:ui racer.state_label set value "比赛中"
execute if data storage magical_athlete:ui racer{status:1} run data modify storage magical_athlete:ui racer.state_label set value "已冲线"
execute if data storage magical_athlete:ui racer{status:2} run data modify storage magical_athlete:ui racer.state_label set value "已淘汰"
data modify storage magical_athlete:ui racer.trip_label set value ""
execute if data storage magical_athlete:ui racer{trip:1} run data modify storage magical_athlete:ui racer.trip_label set value " · 已绊倒"
function magical_athlete:ui/public_racer_show with storage magical_athlete:ui racer
execute store result score #actual_char ma_ctx run data get storage magical_athlete:ui racer.char
execute store result score #actual_power ma_ctx run data get storage magical_athlete:ui racer.power
execute unless score #actual_char ma_ctx = #actual_power ma_ctx if score #actual_power ma_ctx matches 0..35 run function magical_athlete:ui/public_power with storage magical_athlete:ui racer
