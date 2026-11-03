# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage magical_athlete:ui character set from storage magical_athlete:characters chars[$(id)]
$scoreboard players set #ui_code ma_ctx $(code)
scoreboard players operation #ui_code ma_ctx += #ui_base ma_ctx
execute store result storage magical_athlete:ui character.command int 1 run scoreboard players get #ui_code ma_ctx
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:0} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:1} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:2} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:3} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:4} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:5} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:6} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:7} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:8} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:9} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:10} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:11} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:12} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:13} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:14} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:15} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:16} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:17} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:18} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:19} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:20} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:21} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:22} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:23} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:24} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:25} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:26} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:27} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:28} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:29} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:30} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:31} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:32} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:33} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:34} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:35} run data modify storage magical_athlete:ui character.glyph set value ""
function magical_athlete:ui/character_append with storage magical_athlete:ui character
