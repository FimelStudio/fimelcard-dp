# 规则入口位于4×4桌面最外侧一格的外立面：径向2.015格、侧向1.40格
# 本界面不缓存游戏编号，点击时由牌桌控制器的 ct_game 实时分派规则
summon minecraft:text_display ~1.40 ~0.58 ~-2.015 {data:{cardtable:{new_rules:1b}},text:{text:'规则介绍',color:'aqua'},billboard:'fixed',Rotation:[180f,0f],alignment:'center',line_width:120,background:0,shadow:1b,see_through:0b,view_range:20f,brightness:{block:15,sky:15}}
summon minecraft:text_display ~2.015 ~0.58 ~1.40 {data:{cardtable:{new_rules:1b}},text:{text:'规则介绍',color:'aqua'},billboard:'fixed',Rotation:[-90f,0f],alignment:'center',line_width:120,background:0,shadow:1b,see_through:0b,view_range:20f,brightness:{block:15,sky:15}}
summon minecraft:text_display ~-1.40 ~0.58 ~2.015 {data:{cardtable:{new_rules:1b}},text:{text:'规则介绍',color:'aqua'},billboard:'fixed',Rotation:[0f,0f],alignment:'center',line_width:120,background:0,shadow:1b,see_through:0b,view_range:20f,brightness:{block:15,sky:15}}
summon minecraft:text_display ~-2.015 ~0.58 ~-1.40 {data:{cardtable:{new_rules:1b}},text:{text:'规则介绍',color:'aqua'},billboard:'fixed',Rotation:[90f,0f],alignment:'center',line_width:120,background:0,shadow:1b,see_through:0b,view_range:20f,brightness:{block:15,sky:15}}
