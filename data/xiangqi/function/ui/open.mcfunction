function xiangqi:input/context
execute unless entity @s[tag=xq.actor] run return 0
function xiangqi:ui/begin
data modify storage xiangqi:ui phase set value "等待对手行棋。"
execute unless entity @e[tag=xq.current,scores={xq_bot=0},limit=1] run data modify storage xiangqi:ui phase set value "等待电脑行棋。"
execute if score @s xq_side = @e[tag=xq.current,limit=1] xq_turn run data modify storage xiangqi:ui phase set value "轮到你行棋。"
execute if entity @e[tag=xq.current,scores={xq_state=2},limit=1] run data modify storage xiangqi:ui phase set value "棋子移动动画中，请稍候。"
execute if entity @e[tag=xq.current,scores={xq_state=4},limit=1] run data modify storage xiangqi:ui phase set value "本局正在结算。"
execute if entity @e[tag=xq.current,scores={xq_state=1,xq_undo=0},limit=1] run function xiangqi:ui/button {code:6,label:"悔棋",color:"yellow"}
execute if entity @e[tag=xq.current,scores={xq_state=1},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_undo unless entity @e[tag=xq.current,scores={xq_undo=0},limit=1] run function xiangqi:ui/button {code:7,label:"同意悔棋",color:"green"}
execute if entity @e[tag=xq.current,scores={xq_state=1},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_undo unless entity @e[tag=xq.current,scores={xq_undo=0},limit=1] run function xiangqi:ui/button {code:8,label:"拒绝悔棋",color:"gray"}
execute if entity @e[tag=xq.current,scores={xq_state=1,xq_draw=0},limit=1] run function xiangqi:ui/button {code:2,label:"和棋",color:"yellow"}
execute if entity @e[tag=xq.current,scores={xq_state=1,xq_draw=1},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_draw run function xiangqi:ui/button {code:3,label:"接受和棋",color:"green"}
execute if entity @e[tag=xq.current,scores={xq_state=1,xq_draw=-1},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_draw run function xiangqi:ui/button {code:3,label:"接受和棋",color:"green"}
execute if entity @e[tag=xq.current,scores={xq_state=1,xq_draw=1},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_draw run function xiangqi:ui/button {code:4,label:"拒绝和棋",color:"gray"}
execute if entity @e[tag=xq.current,scores={xq_state=1,xq_draw=-1},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_draw run function xiangqi:ui/button {code:4,label:"拒绝和棋",color:"gray"}
execute if entity @e[tag=xq.current,scores={xq_state=1..2},limit=1] run function xiangqi:ui/button {code:9,label:"认输",color:"red"}
execute if entity @e[tag=xq.current,scores={xq_state=1},limit=1] unless entity @e[tag=xq.current,scores={xq_undo=0},limit=1] if score @s xq_side = @e[tag=xq.current,limit=1] xq_undo run data modify storage xiangqi:ui phase set value "已申请悔棋，等待回应。"
execute if entity @e[tag=xq.current,scores={xq_state=1},limit=1] unless entity @e[tag=xq.current,scores={xq_undo=0},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_undo run data modify storage xiangqi:ui phase set value "对手申请悔棋。"
execute if entity @e[tag=xq.current,scores={xq_state=1},limit=1] unless entity @e[tag=xq.current,scores={xq_draw=0},limit=1] if score @s xq_side = @e[tag=xq.current,limit=1] xq_draw run data modify storage xiangqi:ui phase set value "已提出和棋，等待回应。"
execute if entity @e[tag=xq.current,scores={xq_state=1},limit=1] unless entity @e[tag=xq.current,scores={xq_draw=0},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_draw run data modify storage xiangqi:ui phase set value "对手提出和棋。"
function xiangqi:ui/show with storage xiangqi:ui
tag @a[tag=xq.actor] remove xq.actor
