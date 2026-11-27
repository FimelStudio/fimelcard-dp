scoreboard players set @s ct_ui_close 0
scoreboard players enable @s ct_ui_close
$dialog show @s {type:"minecraft:notice",title:{text:"奖励牌 · 弃牌恢复",color:"green",bold:true},body:[{type:"minecraft:plain_message",width:430,contents:{text:"必须立即选择一张弃牌放回剩余牌库。牌面按弃牌先后排列，每行五张。",color:"gray"}},{type:"minecraft:plain_message",width:430,contents:$(restore_view)}],pause:false,can_close_with_escape:false,after_action:"none",action:{label:{text:"返回游戏"},action:{type:"minecraft:run_command",command:"trigger ct_ui_close set 1"}}}
