function chess:input/context
execute unless entity @s[tag=ch.actor] run return 0
execute if entity @e[tag=ch.current,scores={ch_state=3},limit=1] if score @s ch_side = @e[tag=ch.current,limit=1] ch_turn run return run function chess:ui/promotion
function chess:ui/begin
data modify storage chess:ui phase set value "等待对手行棋。"
execute unless entity @e[tag=ch.current,scores={ch_bot=0},limit=1] run data modify storage chess:ui phase set value "等待电脑行棋。"
execute if score @s ch_side = @e[tag=ch.current,limit=1] ch_turn run data modify storage chess:ui phase set value "轮到你行棋。"
execute if entity @e[tag=ch.current,scores={ch_state=2},limit=1] run data modify storage chess:ui phase set value "棋子移动动画中，请稍候。"
execute if entity @e[tag=ch.current,scores={ch_state=3},limit=1] run data modify storage chess:ui phase set value "等待对手选择升变棋子。"
execute if entity @e[tag=ch.current,scores={ch_state=4},limit=1] run data modify storage chess:ui phase set value "本局正在结算。"
execute if entity @e[tag=ch.current,scores={ch_state=1,ch_undo=0},limit=1] run function chess:ui/button {code:6,label:"悔棋",color:"yellow"}
execute if entity @e[tag=ch.current,scores={ch_state=1},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_undo unless entity @e[tag=ch.current,scores={ch_undo=0},limit=1] run function chess:ui/button {code:7,label:"同意悔棋",color:"green"}
execute if entity @e[tag=ch.current,scores={ch_state=1},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_undo unless entity @e[tag=ch.current,scores={ch_undo=0},limit=1] run function chess:ui/button {code:8,label:"拒绝悔棋",color:"gray"}
execute if entity @e[tag=ch.current,scores={ch_state=1,ch_draw=0},limit=1] run function chess:ui/button {code:2,label:"和棋",color:"yellow"}
execute if entity @e[tag=ch.current,scores={ch_state=1,ch_draw=1},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_draw run function chess:ui/button {code:3,label:"接受和棋",color:"green"}
execute if entity @e[tag=ch.current,scores={ch_state=1,ch_draw=-1},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_draw run function chess:ui/button {code:3,label:"接受和棋",color:"green"}
execute if entity @e[tag=ch.current,scores={ch_state=1,ch_draw=1},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_draw run function chess:ui/button {code:4,label:"拒绝和棋",color:"gray"}
execute if entity @e[tag=ch.current,scores={ch_state=1,ch_draw=-1},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_draw run function chess:ui/button {code:4,label:"拒绝和棋",color:"gray"}
execute if entity @e[tag=ch.current,scores={ch_state=1..3},limit=1] run function chess:ui/button {code:9,label:"认输",color:"red"}
execute if entity @e[tag=ch.current,scores={ch_state=1},limit=1] if score @s ch_side = @e[tag=ch.current,limit=1] ch_turn if entity @e[tag=ch.current,scores={ch_half=100..},limit=1] run function chess:ui/button {code:5,label:"认领规则和棋",color:"aqua"}
execute if entity @e[tag=ch.current,scores={ch_state=1,ch_half=..99,ch_repetition=3..},limit=1] if score @s ch_side = @e[tag=ch.current,limit=1] ch_turn run function chess:ui/button {code:5,label:"认领规则和棋",color:"aqua"}
execute if entity @e[tag=ch.current,scores={ch_state=1},limit=1] unless entity @e[tag=ch.current,scores={ch_undo=0},limit=1] if score @s ch_side = @e[tag=ch.current,limit=1] ch_undo run data modify storage chess:ui phase set value "已申请悔棋，等待回应。"
execute if entity @e[tag=ch.current,scores={ch_state=1},limit=1] unless entity @e[tag=ch.current,scores={ch_undo=0},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_undo run data modify storage chess:ui phase set value "对手申请悔棋。"
execute if entity @e[tag=ch.current,scores={ch_state=1},limit=1] unless entity @e[tag=ch.current,scores={ch_draw=0},limit=1] if score @s ch_side = @e[tag=ch.current,limit=1] ch_draw run data modify storage chess:ui phase set value "已提出和棋，等待回应。"
execute if entity @e[tag=ch.current,scores={ch_state=1},limit=1] unless entity @e[tag=ch.current,scores={ch_draw=0},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_draw run data modify storage chess:ui phase set value "对手提出和棋。"
function chess:ui/show with storage chess:ui
tag @a[tag=ch.actor] remove ch.actor
