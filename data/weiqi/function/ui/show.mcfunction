# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$dialog show @s {"type":"minecraft:multi_action","title":{"text":"围棋 · 对局菜单","color":"gold"},"body":[{"type":"minecraft:plain_message","width":470,"contents":{"text":"$(phase)","color":"yellow"}},{"type":"minecraft:plain_message","width":470,"contents":[{"text":"黑方：","color":"gray"},$(black_name),{"text":"\n白方：","color":"white"},$(white_name)]},{"type":"minecraft:plain_message","width":470,"contents":{"text":"行棋：$(turn) · 第$(moves)手\n提子：黑$(bcap) / 白$(wcap)\n白方贴目：$(komi_label)目","color":"gray"}},{"type":"minecraft:plain_message","width":470,"contents":{"text":"$(estimate_note)","color":"aqua"}},{"type":"minecraft:plain_message","width":470,"contents":$(scoreline)}],"columns":2,"actions":$(buttons),"exit_action":{"label":{"text":"返回棋盘"}},"pause":false,"after_action":"none"}
