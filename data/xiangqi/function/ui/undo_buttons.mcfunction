data modify storage xiangqi:ui phase set value "悔棋"
execute if entity @e[tag=xq.current,scores={xq_undo=0},limit=1] run function xiangqi:ui/button {code:6,label:"申请悔棋",color:"yellow"}
execute unless entity @e[tag=xq.current,scores={xq_undo=0},limit=1] if score @s xq_side = @e[tag=xq.current,limit=1] xq_undo run data modify storage xiangqi:ui phase set value "悔棋申请已发出，等待对手回应。"
execute unless entity @e[tag=xq.current,scores={xq_undo=0},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_undo run function xiangqi:ui/button {code:7,label:"同意悔棋",color:"green"}
execute unless entity @e[tag=xq.current,scores={xq_undo=0},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_undo run function xiangqi:ui/button {code:8,label:"拒绝悔棋",color:"gray"}
