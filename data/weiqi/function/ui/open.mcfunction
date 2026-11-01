function weiqi:input/context
execute unless entity @s[tag=go.actor] run return 0
function weiqi:ui/begin
data modify storage weiqi:ui phase set value "等待对手行棋。"
execute if score @s go_side = @e[tag=go.current,limit=1] go_turn run data modify storage weiqi:ui phase set value "轮到你行棋。"
execute if entity @e[tag=go.current,scores={go_state=2},limit=1] run data modify storage weiqi:ui phase set value "落子动画中。"
execute if entity @e[tag=go.current,scores={go_state=3},limit=1] run data modify storage weiqi:ui phase set value "终局点目：请标记死子并确认。"
execute if entity @e[tag=go.current,scores={go_state=4},limit=1] run data modify storage weiqi:ui phase set value "对局已结束，正在返回大厅。"
execute if entity @e[tag=go.current,scores={ct_state=0},limit=1] run data modify storage weiqi:ui phase set value "终局保留：可开始逐手复盘。"
execute if entity @e[tag=go.current,scores={go_state=5},limit=1] run data modify storage weiqi:ui phase set value "复盘中：只读回看，不改终局记录。"
execute if entity @e[tag=go.current,scores={go_state=1},limit=1] if score @s go_side = @e[tag=go.current,limit=1] go_turn run function weiqi:ui/button {code:10,label:"停一手",color:"yellow"}
execute if entity @e[tag=go.current,scores={go_state=1},limit=1] if score @s go_side = @e[tag=go.current,limit=1] go_turn run function weiqi:ui/button {code:50,label:"坐标落子",color:"aqua"}
execute if entity @e[tag=go.current,scores={go_state=1,go_estimate=1},limit=1] unless score @s go_view matches 1 run function weiqi:ui/button {code:11,label:"查看占地",color:"aqua"}
execute if entity @e[tag=go.current,scores={go_state=1,go_estimate=1},limit=1] if score @s go_view matches 1 run function weiqi:ui/button {code:11,label:"关闭占地",color:"gray"}
execute if entity @e[tag=go.current,scores={go_state=1,go_undo=0},limit=1] run function weiqi:ui/button {code:20,label:"申请悔棋",color:"yellow"}
execute if entity @e[tag=go.current,scores={go_state=1},limit=1] unless entity @e[tag=go.current,scores={go_undo=0},limit=1] unless score @s go_side = @e[tag=go.current,limit=1] go_undo run function weiqi:ui/button {code:21,label:"同意悔棋",color:"green"}
execute if entity @e[tag=go.current,scores={go_state=1},limit=1] unless entity @e[tag=go.current,scores={go_undo=0},limit=1] unless score @s go_side = @e[tag=go.current,limit=1] go_undo run function weiqi:ui/button {code:22,label:"拒绝悔棋",color:"gray"}
execute if entity @e[tag=go.current,scores={go_state=1},limit=1] unless entity @e[tag=go.current,scores={go_undo=0},limit=1] if score @s go_side = @e[tag=go.current,limit=1] go_undo run data modify storage weiqi:ui phase set value "已申请悔棋，等待对手回应。"
execute if entity @e[tag=go.current,scores={go_state=1},limit=1] unless entity @e[tag=go.current,scores={go_undo=0},limit=1] unless score @s go_side = @e[tag=go.current,limit=1] go_undo run data modify storage weiqi:ui phase set value "对手申请悔棋。"
execute if entity @e[tag=go.current,scores={go_state=1..2},limit=1] run function weiqi:ui/button {code:30,label:"认输",color:"red"}
execute if entity @e[tag=go.current,scores={go_state=3},limit=1] run function weiqi:ui/button {code:40,label:"确认点目",color:"green"}
execute if entity @e[tag=go.current,scores={go_state=3},limit=1] run function weiqi:ui/button {code:41,label:"继续下棋",color:"yellow"}
execute if entity @e[tag=go.current,scores={go_state=3,go_bconfirm=1},limit=1] if score @s go_side matches 1 run data modify storage weiqi:ui phase set value "你已确认，等待白方确认；改动死子将取消双方确认。"
execute if entity @e[tag=go.current,scores={go_state=3,go_wconfirm=1},limit=1] if score @s go_side matches -1 run data modify storage weiqi:ui phase set value "你已确认，等待黑方确认；改动死子将取消双方确认。"
execute if entity @e[tag=go.current,scores={ct_state=0,go_state=0},limit=1] run function weiqi:ui/button {code:60,label:"逐手复盘",color:"aqua"}
execute if entity @e[tag=go.current,scores={go_state=5},limit=1] run function weiqi:ui/button {code:64,label:"最初棋面",color:"gray"}
execute if entity @e[tag=go.current,scores={go_state=5},limit=1] run function weiqi:ui/button {code:62,label:"上一手",color:"aqua"}
execute if entity @e[tag=go.current,scores={go_state=5},limit=1] run function weiqi:ui/button {code:63,label:"下一手",color:"aqua"}
execute if entity @e[tag=go.current,scores={go_state=5},limit=1] run function weiqi:ui/button {code:65,label:"终局棋面",color:"gray"}
execute if entity @e[tag=go.current,scores={go_state=5,go_autoplay=0},limit=1] run function weiqi:ui/button {code:66,label:"自动播放",color:"green"}
execute if entity @e[tag=go.current,scores={go_state=5,go_autoplay=1},limit=1] run function weiqi:ui/button {code:66,label:"暂停播放",color:"yellow"}
execute if entity @e[tag=go.current,scores={go_state=5},limit=1] run function weiqi:ui/button {code:61,label:"退出复盘",color:"red"}
function weiqi:ui/button {code:70,label:"规则",color:"white"}
function weiqi:ui/show with storage weiqi:ui
tag @a[tag=go.actor] remove go.actor
