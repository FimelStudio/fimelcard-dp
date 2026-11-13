# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$dialog show @s {type:"minecraft:multi_action",title:{text:"$(title)",color:"gold"},body:[{type:"minecraft:plain_message",width:470,contents:{text:"$(phase)",color:"yellow"}},{type:"minecraft:plain_message",width:470,contents:{text:"当前行动：",color:"gray",extra:[$(turn_name)]}},{type:"minecraft:plain_message",width:470,contents:$(guidance)},{type:"minecraft:plain_message",width:470,contents:$(private)},{type:"minecraft:plain_message",width:470,contents:$(public)},{type:"minecraft:plain_message",width:470,contents:$(note)}],columns:$(columns),actions:$(buttons),exit_action:{label:{text:"返回棋盘"}},pause:false,after_action:"none"}
