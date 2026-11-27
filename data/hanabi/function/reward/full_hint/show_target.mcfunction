scoreboard players set @s ct_ui_close 0
scoreboard players enable @s ct_ui_close
$dialog show @s {type:"minecraft:notice",title:{text:"奖励牌 · 完全提示",color:"aqua",bold:true},body:[{type:"minecraft:plain_message",width:430,contents:$(full_hint_target_body)}],pause:false,can_close_with_escape:false,after_action:"none",action:{label:{text:"返回游戏"},action:{type:"minecraft:run_command",command:"trigger ct_ui_close set 1"}}}
