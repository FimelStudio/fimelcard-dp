# 仅供独立 GameTest 世界使用；不要复制到生产 data/。
# 调用处不需要真实玩家：宏创建时先解码 Dialog，即使玩家 selector 为空也可检查 codec。
say UNO_DIALOGS_BEGIN
data merge storage uno:ui {"phase":{"text":"轮到你：选牌或摸一张。","color":"green"},"top":{"text":"红·跳过","color":"red"},"color":{"text":"红","color":"red"},"direction":"顺时针","selected":{"text":"变色+4","color":"gold"},"players":{"text":"1号位：7张 · 0分\n3号位：7张 · 0分"},"grid":{"text":"\n\n\n","shadow_color":0,"extra":[{"text":"✓","color":"gold"},{"text":"","font":"card:uno/dialog","color":"white"},{"text":"×2  ","color":"white"}]},"controls":[{"label":{"text":"出牌","color":"green"},"width":140,"action":{"type":"minecraft:run_command","command":"trigger un_action set 1001"}}],"colors":[{"label":{"text":"红","color":"red"},"width":100,"action":{"type":"minecraft:run_command","command":"trigger un_action set 1200"}},{"label":{"text":"黄","color":"yellow"},"width":100,"action":{"type":"minecraft:run_command","command":"trigger un_action set 1201"}},{"label":{"text":"绿","color":"green"},"width":100,"action":{"type":"minecraft:run_command","command":"trigger un_action set 1202"}},{"label":{"text":"蓝","color":"blue"},"width":100,"action":{"type":"minecraft:run_command","command":"trigger un_action set 1203"}}],"pick":1100,"count":2,"glyph":"","name":"红0","mark":"✓","line_seat":1,"line_count":7,"line_score":0,"line_turn":" ▶","table":123,"code":1001,"label":"出牌","control_color":"green","buttons":[]}
data modify storage uno:ui line_name set value {text:"示例玩家",color:"white"}
data modify storage uno:ui card_font set value "card:uno/dialog_selected"
data modify storage uno:ui pick_hint set value "已选中 · 再点取消"
data modify storage uno:ui grid.extra set value [{text:"",font:"card:uno/dialog_selected",color:"white"},{text:"×2  ",color:"white"}]
data modify storage uno:ui grid.text set value "\n\n\n\n\n"
function uno:ui/show with storage uno:ui
say UNO_DIALOG_HAND_COMPILED
# 等待其他玩家时不再放刷新按钮，空操作列表也必须能解码。
data modify storage uno:ui controls set value []
function uno:ui/show with storage uno:ui
say UNO_DIALOG_WAITING_COMPILED
function uno:ui/colors_show with storage uno:ui
say UNO_DIALOG_COLORS_COMPILED
function uno:ui/append_card with storage uno:ui
function uno:ui/player_append with storage uno:ui
function uno:ui/control_append with storage uno:ui
function uno:ui/color_append with storage uno:ui
data merge storage uno:settings {mode:0,rounds:3,target:500,auto:0,challenge:1,seconds:3,target_hundreds:5,close:100000}
scoreboard players set #ui_setting_base un_ctx 100000
function uno:settings/root with storage uno:settings
say UNO_DIALOG_SETTING_SINGLE_PAGE_COMPILED
data merge storage uno:settings {mode:1,rounds:1,target:100,auto:1,challenge:0,seconds:1,target_hundreds:1}
function uno:settings/root with storage uno:settings
say UNO_DIALOG_SETTING_MINIMUM_COMPILED
data merge storage uno:settings {mode:2,rounds:32,target:1000,auto:0,challenge:1,seconds:5,target_hundreds:10}
function uno:settings/root with storage uno:settings
say UNO_DIALOG_SETTING_MAXIMUM_COMPILED
function uno:rules/show
say UNO_DIALOGS_END
