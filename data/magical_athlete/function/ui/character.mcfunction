# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage magical_athlete:ui character set from storage magical_athlete:characters chars[$(id)]
$scoreboard players set #ui_code ma_ctx $(code)
scoreboard players operation #ui_code ma_ctx += #ui_base ma_ctx
execute store result storage magical_athlete:ui character.command int 1 run scoreboard players get #ui_code ma_ctx
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:0} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:1} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:2} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:3} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:4} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:5} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:6} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:7} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:8} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:9} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:10} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:11} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:12} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:13} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:14} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:15} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:16} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:17} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:18} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:19} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:20} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:21} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:22} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:23} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:24} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:25} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:26} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:27} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:28} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:29} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:30} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:31} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:32} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:33} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:34} run data modify storage magical_athlete:ui character.glyph set value ""
$execute if predicate {type:"minecraft:int_value_check",value:$(id),test:35} run data modify storage magical_athlete:ui character.glyph set value ""
function magical_athlete:ui/character_append with storage magical_athlete:ui character
