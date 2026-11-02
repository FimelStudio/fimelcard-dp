# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless data storage love_letter:ui phase.extra[0] run data remove storage love_letter:ui phase.extra
execute unless data storage love_letter:ui rows.extra[0] run data remove storage love_letter:ui rows.extra
execute unless data storage love_letter:ui cards.extra[0] run data remove storage love_letter:ui cards.extra
execute unless data storage love_letter:ui info.extra[0] run data remove storage love_letter:ui info.extra
