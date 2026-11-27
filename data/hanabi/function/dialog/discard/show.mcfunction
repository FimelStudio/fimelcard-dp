scoreboard players set @s ct_ui_close 0
scoreboard players enable @s ct_ui_close
$dialog show @s {type:"minecraft:notice",title:{text:"花火 · 弃牌堆",color:"aqua"},body:[{type:"minecraft:plain_message",width:430,contents:{text:"按实际弃牌先后排列",color:"gray"}},{type:"minecraft:plain_message",width:430,contents:$(discard_view)}],pause:false,can_close_with_escape:false,action:{label:{text:"返回回合操作",color:"green"},action:{type:"minecraft:run_command",command:"trigger hb_action set 701"}},after_action:"none"}
