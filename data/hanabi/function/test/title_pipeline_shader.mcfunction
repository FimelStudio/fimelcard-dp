# C：使用写死的 BetterTitle 编码组件，不经过面板创建、storage 或宏。
# 若 C 能出现在左上角，说明 26.2 着色器移植已生效。

tag @s add hb.title_test_direct
title @s actionbar [{text:"\u4016",font:"title:x_displace"},{text:"\u2464",font:"title:y_displace"},{text:"5",font:"title:o_displace"},{text:"",font:"minecraft:default_mod",extra:[{text:"阶段 C：静态左侧定位正常",color:"aqua",shadow_color:0}]},{text:"",font:"minecraft:default_neg",extra:[{text:"阶段 C：静态左侧定位正常",color:"aqua",shadow_color:0}]},{text:"",font:"minecraft:default_neg",extra:[{text:"阶段 C：静态左侧定位正常",color:"aqua",shadow_color:0}]},{text:"\u4016",font:"title:x_displace_neg"},{text:"\u2464",font:"title:y_displace_neg"},{text:"5",font:"title:o_displace_neg"}]
tellraw @s [{text:"[花火测试] ",color:"light_purple",bold:true},{text:"阶段 C 已发送：屏幕左上角应显示青色的“阶段 C”。",color:"gray"}]
tellraw @s [{text:"[继续阶段 D：测试完整动态面板]",color:"aqua",underlined:true,click_event:{action:"run_command",command:"/function hanabi:test/title_left"},hover_event:{action:"show_text",value:{text:"点击执行",color:"yellow"}}},{text:"  "},{text:"[结束测试]",color:"red",underlined:true,click_event:{action:"run_command",command:"/function hanabi:test/title_left_clear"}}]
