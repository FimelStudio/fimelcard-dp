function magical_athlete:visual/context
execute as @e[tag=ma.event_prop] if score @s ct_id = #vis_table ma_ctx run kill @s
scoreboard players set @s ma_vtimer 0
scoreboard players set @s ma_vframe 0
execute as @e[tag=ma.racer] if score @s ct_id = #vis_table ma_ctx run tag @s add ma.outdated
execute as @e[tag=ma.racer_name] if score @s ct_id = #vis_table ma_ctx run tag @s add ma.outdated
data modify storage magical_athlete:visual track set value "mild"
execute if data entity @s data.magical_athlete{track:1} run data modify storage magical_athlete:visual track set value "wild"
function magical_athlete:visual/board_sync with storage magical_athlete:visual
function magical_athlete:visual/dice_sync with storage magical_athlete:visual
function magical_athlete:visual/dice_restore
execute if data entity @s data.magical_athlete.racers[0] run function magical_athlete:visual/racer_spawn {index:0}
execute if data entity @s data.magical_athlete.racers[1] run function magical_athlete:visual/racer_spawn {index:1}
execute if data entity @s data.magical_athlete.racers[2] run function magical_athlete:visual/racer_spawn {index:2}
execute if data entity @s data.magical_athlete.racers[3] run function magical_athlete:visual/racer_spawn {index:3}
execute if data entity @s data.magical_athlete.racers[4] run function magical_athlete:visual/racer_spawn {index:4}
execute if data entity @s data.magical_athlete.racers[5] run function magical_athlete:visual/racer_spawn {index:5}
execute as @e[tag=ma.outdated] if score @s ct_id = #vis_table ma_ctx run kill @s
function magical_athlete:direct/board_refresh
function magical_athlete:visual/info_update
