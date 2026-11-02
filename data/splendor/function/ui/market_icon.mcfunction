# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
data modify storage splendor:ui image set value {text:"[空位]",color:"gray"}
$execute if predicate {condition:"minecraft:value_check",value:$(icon_id),range:{min:0,max:89}} run function splendor:ui/card_icon {id:$(icon_id)}
$data modify storage splendor:ui image.click_event set value {action:"run_command",command:"trigger sp_action set $(code)"}
data modify storage splendor:ui picture.extra append from storage splendor:ui image
data modify storage splendor:ui picture.extra append value {text:"  "}
