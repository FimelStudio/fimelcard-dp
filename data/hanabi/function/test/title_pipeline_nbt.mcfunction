# B：使用与上游 display_macro 相同的“storage 列表 + interpret”写法。
# 若 A 可见而 B 不可见，才说明 26.2 的数据组件读取方式发生了变化。

tag @s add hb.title_test_direct
data modify storage hanabi:test title_pipeline_panel set value [{text:"阶段 B：动态 NBT 列表正常",color:"yellow",bold:true}]
title @s actionbar {nbt:"title_pipeline_panel",storage:"hanabi:test",interpret:true}
tellraw @s [{text:"[花火测试] ",color:"light_purple",bold:true},{text:"阶段 B 已发送：物品栏上方应显示黄色的“阶段 B”。",color:"gray"}]
tellraw @s [{text:"[继续阶段 C：测试着色器定位]",color:"aqua",underlined:true,click_event:{action:"run_command",command:"/function hanabi:test/title_pipeline_shader"},hover_event:{action:"show_text",value:{text:"点击执行",color:"yellow"}}},{text:"  "},{text:"[结束测试]",color:"red",underlined:true,click_event:{action:"run_command",command:"/function hanabi:test/title_left_clear"}}]
