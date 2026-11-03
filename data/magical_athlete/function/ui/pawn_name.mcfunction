# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage magical_athlete:ui character set from storage magical_athlete:characters chars[$(char)]
$scoreboard players set #button_code ma_ctx $(index)
scoreboard players add #button_code ma_ctx 300
execute store result storage magical_athlete:ui character.code int 1 run scoreboard players get #button_code ma_ctx
function magical_athlete:ui/pawn_label with storage magical_athlete:ui character
