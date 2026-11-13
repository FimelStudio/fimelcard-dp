# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage magical_athlete:ui target set from storage magical_athlete:ui pending.options[$(index)]
execute store result score #option ma_ctx run data get storage magical_athlete:ui target
scoreboard players operation #choice_code ma_ctx = #option ma_ctx
scoreboard players add #choice_code ma_ctx 2100
execute store result storage magical_athlete:ui option.code int 1 run scoreboard players get #choice_code ma_ctx
data modify storage magical_athlete:ui option.target set from storage magical_athlete:ui target
data modify storage magical_athlete:ui option.kind set from storage magical_athlete:ui pending.kind
function magical_athlete:ui/option_label with storage magical_athlete:ui option
