data modify storage gomoku:ui phase set value "悔棋"
execute if entity @e[tag=gm.current,scores={gm_undo=0},limit=1] run function gomoku:ui/button {code:6,label:"申请悔棋",color:"yellow"}
execute unless entity @e[tag=gm.current,scores={gm_undo=0},limit=1] if score @s gm_side = @e[tag=gm.current,limit=1] gm_undo run data modify storage gomoku:ui phase set value "悔棋申请已发出，等待对手回应。"
execute unless entity @e[tag=gm.current,scores={gm_undo=0},limit=1] unless score @s gm_side = @e[tag=gm.current,limit=1] gm_undo run function gomoku:ui/button {code:7,label:"同意悔棋",color:"green"}
execute unless entity @e[tag=gm.current,scores={gm_undo=0},limit=1] unless score @s gm_side = @e[tag=gm.current,limit=1] gm_undo run function gomoku:ui/button {code:8,label:"拒绝悔棋",color:"gray"}
