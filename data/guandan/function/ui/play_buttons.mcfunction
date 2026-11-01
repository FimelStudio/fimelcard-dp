function guandan:ui/button {code:20,label:"出牌",color:"green"}
execute unless score @e[tag=gd.current,limit=1] gd_lastkind matches 0 run function guandan:ui/button {code:21,label:"不出",color:"yellow"}
