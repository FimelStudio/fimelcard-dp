# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$dialog show @s {"type":"minecraft:confirmation","title":{"text":"五子棋 · 坐标落子","color":"gold"},"body":[{"type":"minecraft:plain_message","width":460,"contents":{"text":"列从黑方视角左到右，行从黑方一侧向对面。","color":"white"}}],"inputs":[{"type":"minecraft:number_range","key":"row","label":{"text":"行"},"start":1,"end":$(size),"step":1,"initial":1,"width":300},{"type":"minecraft:number_range","key":"col","label":{"text":"列（A=1，B=2……）"},"start":1,"end":$(size),"step":1,"initial":1,"width":300}],"yes":{"label":{"text":"落子","color":"green"},"action":{"type":"minecraft:dynamic/run_command","template":"trigger gm_coord set $(nonce)$(row)0$(col)"}},"no":{"label":{"text":"取消"}},"pause":false}
