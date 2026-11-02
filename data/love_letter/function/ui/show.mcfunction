# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$dialog show @s {"type":"minecraft:multi_action","title":{"text":"$(title)","color":"gold"},"body":[{"type":"minecraft:plain_message","width":480,"contents":$(phase)},{"type":"minecraft:plain_message","width":480,"contents":$(rows)},{"type":"minecraft:plain_message","width":480,"contents":$(cards)},{"type":"minecraft:plain_message","width":480,"contents":$(info)}],"actions":$(buttons),"columns":2,"exit_action":{"label":{"text":"返回游戏"}},"pause":false,"can_close_with_escape":true,"after_action":"none"}
