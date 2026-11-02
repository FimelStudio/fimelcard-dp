# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$dialog show @s {"type":"minecraft:multi_action","title":{"text":"掼蛋 · 手牌","color":"gold"},"body":[{"type":"minecraft:plain_message","width":440,"contents":$(phase)},{"type":"minecraft:plain_message","width":440,"contents":[{"text":"上一手：","color":"gray"},$(last_play)]},{"type":"minecraft:plain_message","width":440,"contents":$(info)},{"type":"minecraft:plain_message","width":440,"contents":{"text":"从大到小排列，同点数上下堆叠；点击露出的牌面选中／取消，金边表示选中，★表示级牌（红桃级牌为逢人配）。","color":"gray"}},{"type":"minecraft:plain_message","width":690,"contents":$(grid)}],"columns":4,"actions":$(buttons),"exit_action":{"label":{"text":"返回游戏（保留选择）"}},"pause":false,"can_close_with_escape":true,"after_action":"close"}
