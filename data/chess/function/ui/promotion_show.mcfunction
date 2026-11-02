# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$dialog show @s {"type":"minecraft:multi_action","title":{"text":"国际象棋 · 兵的升变","color":"gold"},"body":[{"type":"minecraft:plain_message","width":460,"contents":{"text":"请选择升变棋子。","color":"white"}}],"columns":2,"actions":$(buttons),"exit_action":{"label":{"text":"稍后选择"}},"pause":false}
