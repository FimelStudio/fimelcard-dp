# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$dialog show @s {"type":"minecraft:multi_action","title":{"text":"飞行棋 · 对局","color":"gold"},"body":[{"type":"minecraft:plain_message","width":380,"contents":{"text":"$(status)\n你：$(own)方 · 当前：$(color)方 · 骰子：$(dice)"}}],"pause":false,"can_close_with_escape":true,"after_action":"close","actions":$(buttons),"columns":2,"exit_action":{"label":{"text":"返回游戏"},"width":140}}
