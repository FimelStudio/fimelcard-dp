# 独立测试花火字体与BetterTitle左上角定位，不依赖牌桌、游戏状态或其他玩家
function hanabi:title/ensure_library

# 若玩家刚完成分层测试，则恢复 BetterTitle 的逐刻面板输出
tag @s remove hb.title_test_direct

# 首次进入测试时保存原面板；重复执行不会把测试面板覆盖进恢复值
execute unless entity @s[tag=hb.title_test_active] run scoreboard players set @s hb_test_prev 0
execute unless entity @s[tag=hb.title_test_active] if score @s title.panel_id matches 1.. run scoreboard players operation @s hb_test_prev = @s title.panel_id
tag @s add hb.title_test_active

# 测试期间阻止文本动画库占用Actionbar，退出时只清除本测试自己添加的标签
execute unless entity @s[tag=cgt_anim_text.replace.actionbar] run tag @s add hb.title_test_owns_actionbar
tag @s add cgt_anim_text.replace.actionbar

# 为执行者分配独立测试面板
function title:new_panel {id:"@s hb_test_panel"}
data modify storage title:io panel_buffer set value []
data modify storage title:io text_buffer set value []
data modify storage title:io neg_text_buffer set value []

# 第一行：先验证BetterTitle能否把普通文字定位到屏幕左上角
data modify storage title:io text set value {text:"BetterTitle 左侧定位测试",color:"aqua",shadow_color:0}
data modify storage title:io font set value "minecraft:default_mod"
data modify storage title:io neg_font set value "minecraft:default_neg"
data modify storage title:io x set value 8.0d
data modify storage title:io y set value -18.0d
data modify storage title:io dx set value 0.0d
data modify storage title:io dy set value 0.0d
data modify storage title:io align set value "left"
data modify storage title:io origin set value "up-left"
function title:new_text

# 第二行：直接使用花火牌面字体，依次显示红1、蓝2、黄3、绿4、白5
data modify storage title:io text set value {text:"\uE201\uE302\uE403\uE504\uE105",color:"white",shadow_color:0}
data modify storage title:io font set value "card:hanabi_title"
data modify storage title:io neg_font set value "card:hanabi_title_neg"
data modify storage title:io x set value 8.0d
data modify storage title:io y set value -56.0d
data modify storage title:io dx set value 0.0d
data modify storage title:io dy set value 0.0d
data modify storage title:io align set value "left"
data modify storage title:io origin set value "up-left"
function title:new_text

# 第三行：再放一组不同牌面，用于确认多行纵向位移是否生效
data modify storage title:io text set value {text:"\uE505\uE404\uE303\uE202\uE101",color:"white",shadow_color:0}
data modify storage title:io font set value "card:hanabi_title"
data modify storage title:io neg_font set value "card:hanabi_title_neg"
data modify storage title:io x set value 8.0d
data modify storage title:io y set value -101.0d
data modify storage title:io dx set value 0.0d
data modify storage title:io dy set value 0.0d
data modify storage title:io align set value "left"
data modify storage title:io origin set value "up-left"
function title:new_text

# 提交面板并交给BetterTitle逐刻显示
scoreboard players operation panel_id title.io = @s hb_test_panel
function title:replace_panel
scoreboard players operation @s title.panel_id = @s hb_test_panel

# 聊天字体测试绕过BetterTitle；它能帮助区分字体资源与屏幕定位两类故障
tellraw @s [{text:"[花火测试] ",color:"light_purple",bold:true},{text:"聊天字体：",color:"gray"},{text:"\uE201\uE302\uE403\uE504\uE105",font:"card:hanabi_title",color:"white",shadow_color:0}]
tellraw @s [{text:"[花火测试] ",color:"light_purple"},{text:"屏幕左上角现在应有标题和两行牌面。测试面板编号：",color:"yellow"},{score:{name:"@s",objective:"hb_test_panel"},color:"aqua"},{text:"　[清除测试]",color:"red",underlined:true,click_event:{action:"run_command",command:"/function hanabi:test/title_left_clear"}}]
