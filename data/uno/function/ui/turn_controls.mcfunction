execute if score @s un_pick matches 0..53 run function uno:ui/control {code:1,label:"出牌",color:"white"}
execute if score @s un_pick matches 0..53 run function uno:ui/control {code:2,label:"出牌并喊 UNO",color:"green"}
execute if entity @e[tag=un.current,scores={un_drew=0},limit=1] run function uno:ui/control {code:3,label:"摸一张",color:"aqua"}
execute if entity @e[tag=un.current,scores={un_drew=1},limit=1] run function uno:ui/control {code:4,label:"摸后不出",color:"yellow"}
