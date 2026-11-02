# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$execute if predicate {condition:"minecraft:value_check",value:$(icon_id),range:-1} run data modify storage splendor:ui picture.extra append value {text:"[空]  ",color:"dark_gray"}
$execute if predicate {condition:"minecraft:value_check",value:$(icon_id),range:0} run data modify storage splendor:ui picture.extra append value {"text":"  ","font":"card:splendor/cards","color":"white"}
$execute if predicate {condition:"minecraft:value_check",value:$(icon_id),range:1} run data modify storage splendor:ui picture.extra append value {"text":"  ","font":"card:splendor/cards","color":"white"}
$execute if predicate {condition:"minecraft:value_check",value:$(icon_id),range:2} run data modify storage splendor:ui picture.extra append value {"text":"  ","font":"card:splendor/cards","color":"white"}
$execute if predicate {condition:"minecraft:value_check",value:$(icon_id),range:3} run data modify storage splendor:ui picture.extra append value {"text":"  ","font":"card:splendor/cards","color":"white"}
$execute if predicate {condition:"minecraft:value_check",value:$(icon_id),range:4} run data modify storage splendor:ui picture.extra append value {"text":"  ","font":"card:splendor/cards","color":"white"}
$execute if predicate {condition:"minecraft:value_check",value:$(icon_id),range:5} run data modify storage splendor:ui picture.extra append value {"text":"  ","font":"card:splendor/cards","color":"white"}
$execute if predicate {condition:"minecraft:value_check",value:$(icon_id),range:6} run data modify storage splendor:ui picture.extra append value {"text":"  ","font":"card:splendor/cards","color":"white"}
$execute if predicate {condition:"minecraft:value_check",value:$(icon_id),range:7} run data modify storage splendor:ui picture.extra append value {"text":"  ","font":"card:splendor/cards","color":"white"}
$execute if predicate {condition:"minecraft:value_check",value:$(icon_id),range:8} run data modify storage splendor:ui picture.extra append value {"text":"  ","font":"card:splendor/cards","color":"white"}
$execute if predicate {condition:"minecraft:value_check",value:$(icon_id),range:9} run data modify storage splendor:ui picture.extra append value {"text":"  ","font":"card:splendor/cards","color":"white"}
