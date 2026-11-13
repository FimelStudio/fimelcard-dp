# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$dialog show @s {type:"minecraft:multi_action",title:{text:"UNO · 手牌",color:"gold"},body:[{type:"minecraft:plain_message",width:460,contents:$(phase)},{type:"minecraft:plain_message",width:460,contents:[{text:"顶牌：",color:"gray"},$(top),{text:" · 当前颜色：",color:"gray"},$(color),{text:" · $(direction)\n已选：",color:"gray"},$(selected)]},{type:"minecraft:plain_message",width:660,contents:$(grid)}],columns:3,actions:$(controls),exit_action:{label:{text:"返回游戏"},width:140},pause:false,can_close_with_escape:true,after_action:"close"}
