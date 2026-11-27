scoreboard players set @s ct_ui_close 0
scoreboard players enable @s ct_ui_close
$dialog show @s {type:"minecraft:notice",title:{text:"选择提示对象",color:"yellow"},body:[{type:"minecraft:plain_message",width:430,contents:$(target_body)}],pause:false,can_close_with_escape:false,action:{label:{text:"取消提示",color:"gray"},action:{type:"minecraft:run_command",command:"trigger hb_action set 390"}},after_action:"none"}
