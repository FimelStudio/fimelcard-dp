# BetterTitle 26.2 分层诊断入口
# A：完全绕过 BetterTitle 数据，先检查原版 Actionbar 是否正常。

function hanabi:title/ensure_library
execute unless entity @s[tag=hb.title_test_active] run scoreboard players set @s hb_test_prev 0
execute unless entity @s[tag=hb.title_test_active] if score @s title.panel_id matches 1.. run scoreboard players operation @s hb_test_prev = @s title.panel_id
tag @s add hb.title_test_active
tag @s add hb.title_test_direct

title @s actionbar {text:"阶段 A：原版 Actionbar 正常",color:"green",bold:true}
tellraw @s [{text:"[花火测试] ",color:"light_purple",bold:true},{text:"阶段 A 已发送：物品栏上方应显示绿色的“阶段 A”。",color:"gray"}]
tellraw @s [{text:"[继续阶段 B：测试动态 NBT 列表]",color:"aqua",underlined:true,click_event:{action:"run_command",command:"/function hanabi:test/title_pipeline_nbt"},hover_event:{action:"show_text",value:{text:"点击执行",color:"yellow"}}},{text:"  "},{text:"[结束测试]",color:"red",underlined:true,click_event:{action:"run_command",command:"/function hanabi:test/title_left_clear"}}]
