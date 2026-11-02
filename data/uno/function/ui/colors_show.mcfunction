# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$dialog show @s {type:"minecraft:multi_action",title:{text:"UNO · 选择新颜色",color:"gold"},body:[{type:"minecraft:plain_message",width:380,contents:{text:"选择颜色后才会出牌。变色+4可被下家质疑；手中有当前颜色牌时出+4属于违规。"}}],columns:4,actions:$(colors),exit_action:{label:{text:"暂不出牌"}},pause:false}
