# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
data modify storage gomoku:ui phase set value "和棋"
execute if entity @e[tag=gm.current,scores={gm_draw=0},limit=1] run function gomoku:ui/button {code:2,label:"提出和棋",color:"yellow"}
execute unless entity @e[tag=gm.current,scores={gm_draw=0},limit=1] if score @s gm_side = @e[tag=gm.current,limit=1] gm_draw run data modify storage gomoku:ui phase set value "和棋申请已发出，等待对手回应。"
execute unless entity @e[tag=gm.current,scores={gm_draw=0},limit=1] unless score @s gm_side = @e[tag=gm.current,limit=1] gm_draw run function gomoku:ui/button {code:3,label:"同意和棋",color:"green"}
execute unless entity @e[tag=gm.current,scores={gm_draw=0},limit=1] unless score @s gm_side = @e[tag=gm.current,limit=1] gm_draw run function gomoku:ui/button {code:4,label:"拒绝和棋",color:"gray"}
