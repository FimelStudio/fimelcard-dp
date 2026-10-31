data modify storage xiangqi:ui phase set value "和棋"
execute if entity @e[tag=xq.current,scores={xq_draw=0},limit=1] run function xiangqi:ui/button {code:2,label:"提出和棋",color:"yellow"}
execute unless entity @e[tag=xq.current,scores={xq_draw=0},limit=1] if score @s xq_side = @e[tag=xq.current,limit=1] xq_draw run data modify storage xiangqi:ui phase set value "和棋申请已发出，等待对手回应。"
execute unless entity @e[tag=xq.current,scores={xq_draw=0},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_draw run function xiangqi:ui/button {code:3,label:"同意和棋",color:"green"}
execute unless entity @e[tag=xq.current,scores={xq_draw=0},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_draw run function xiangqi:ui/button {code:4,label:"拒绝和棋",color:"gray"}
