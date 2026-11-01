execute if entity @e[tag=gd.current,scores={gd_phase=1},limit=1] if entity @e[tag=gd.me,scores={gd_tribute=1},limit=1] run function guandan:ui/button {code:23,label:"确定贡牌",color:"green"}
execute if entity @e[tag=gd.current,scores={gd_phase=2},limit=1] if entity @e[tag=gd.me,scores={gd_return=1},limit=1] run function guandan:ui/button {code:23,label:"确定还牌",color:"green"}
