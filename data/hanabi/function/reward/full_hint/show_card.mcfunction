scoreboard players set @s ct_ui_close 0
scoreboard players enable @s ct_ui_close
$dialog show @s {type:"minecraft:notice",title:{text:"奖励牌 · 完全提示",color:"aqua",bold:true},body:[{type:"minecraft:plain_message",width:520,contents:[{text:"目标：",color:"gray"},$(full_hint_name),{text:"\n点击一张牌，立即同时公开它的颜色和数字。\n真实手牌：　",color:"gray"},$(full_hint_cards),{text:"           提示状态：　",color:"gray"},$(full_hint_status),{text:"\n\n",color:"gray"}]}],pause:false,can_close_with_escape:false,after_action:"none",action:{label:{text:"返回游戏"},action:{type:"minecraft:run_command",command:"trigger ct_ui_close set 1"}}}
