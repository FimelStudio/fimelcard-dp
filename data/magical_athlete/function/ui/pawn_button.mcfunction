# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage magical_athlete:ui racer set from entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[$(index)]
$data modify storage magical_athlete:ui racer.index set value $(index)
execute store result score #pawn_owner ma_ctx run data get storage magical_athlete:ui racer.owner
execute unless score #pawn_owner ma_ctx = @s ma_side run return 0
execute if data storage magical_athlete:ui racer{status:1} run return 0
execute if data storage magical_athlete:ui racer{status:2} run return 0
execute if data storage magical_athlete:ui racer{done:1} run return 0
scoreboard players set #forced ma_ctx -1
execute store result score #forced ma_ctx run data get entity @e[tag=ma.current,limit=1] data.magical_athlete.forced
$scoreboard players set #pawn_index ma_ctx $(index)
execute if score #forced ma_ctx matches 0..5 unless score #forced ma_ctx = #pawn_index ma_ctx run return 0
scoreboard players set #allowed ma_ctx 1
execute if score #forced ma_ctx matches -1 if score #pawn_index ma_ctx matches 1..5 if data entity @e[tag=ma.current,limit=1] data.magical_athlete{n:2} run function magical_athlete:ui/prior_pawn {index:0}
execute if score #forced ma_ctx matches -1 if score #pawn_index ma_ctx matches 2..5 if data entity @e[tag=ma.current,limit=1] data.magical_athlete{n:2} run function magical_athlete:ui/prior_pawn {index:1}
execute if score #forced ma_ctx matches -1 if score #pawn_index ma_ctx matches 3..5 if data entity @e[tag=ma.current,limit=1] data.magical_athlete{n:2} run function magical_athlete:ui/prior_pawn {index:2}
execute if score #forced ma_ctx matches -1 if score #pawn_index ma_ctx matches 4..5 if data entity @e[tag=ma.current,limit=1] data.magical_athlete{n:2} run function magical_athlete:ui/prior_pawn {index:3}
execute if score #forced ma_ctx matches -1 if score #pawn_index ma_ctx matches 5..5 if data entity @e[tag=ma.current,limit=1] data.magical_athlete{n:2} run function magical_athlete:ui/prior_pawn {index:4}
execute unless score #allowed ma_ctx matches 1 run return 0
function magical_athlete:ui/pawn_name with storage magical_athlete:ui racer
