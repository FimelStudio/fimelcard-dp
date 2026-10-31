data modify storage chess:ui phase set value "和棋"
execute if entity @e[tag=ch.current,scores={ch_draw=0},limit=1] run function chess:ui/button {code:2,label:"提出和棋",color:"yellow"}
execute unless entity @e[tag=ch.current,scores={ch_draw=0},limit=1] if score @s ch_side = @e[tag=ch.current,limit=1] ch_draw run data modify storage chess:ui phase set value "和棋申请已发出，等待对手回应。"
execute unless entity @e[tag=ch.current,scores={ch_draw=0},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_draw run function chess:ui/button {code:3,label:"同意和棋",color:"green"}
execute unless entity @e[tag=ch.current,scores={ch_draw=0},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_draw run function chess:ui/button {code:4,label:"拒绝和棋",color:"gray"}
execute if score @s ch_side = @e[tag=ch.current,limit=1] ch_turn run function chess:ui/button {code:5,label:"认领规则和棋",color:"aqua"}
