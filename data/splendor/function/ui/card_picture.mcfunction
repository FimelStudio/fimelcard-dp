# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$function splendor:ui/card_icon {id:$(icon_id)}
data modify storage splendor:ui picture set value {text:"\n\n\n\n\n\n",extra:[]}
data modify storage splendor:ui picture.extra append from storage splendor:ui image
