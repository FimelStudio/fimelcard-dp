# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$dialog show @s {"type":"minecraft:notice","title":{"text":"五子棋 · 对局面板","color":"gold"},"body":[{"type":"minecraft:plain_message","width":460,"contents":{"text":"$(phase)","color":"yellow"}}],"pause":false}
