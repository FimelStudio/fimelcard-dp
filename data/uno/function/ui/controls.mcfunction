data modify storage uno:ui controls set value []
execute if entity @e[tag=un.current,scores={un_state=2},limit=1] if score @s un_seat = @e[tag=un.current,limit=1] un_turn run function uno:ui/turn_controls
execute if entity @e[tag=un.current,scores={un_state=3},limit=1] if score @s un_seat = @e[tag=un.current,limit=1] un_pending run function uno:ui/control {code:5,label:"补喊 UNO",color:"green"}
execute if entity @e[tag=un.current,scores={un_state=3},limit=1] unless score @s un_seat = @e[tag=un.current,limit=1] un_pending run function uno:ui/control {code:6,label:"抓 UNO",color:"yellow"}
execute if entity @e[tag=un.current,scores={un_state=4},limit=1] if score @s un_seat = @e[tag=un.current,limit=1] un_challenger run function uno:ui/control {code:7,label:"接受：摸4并跳过",color:"yellow"}
execute if entity @e[tag=un.current,scores={un_state=4},limit=1] if score @s un_seat = @e[tag=un.current,limit=1] un_challenger run function uno:ui/control {code:8,label:"质疑 +4",color:"red"}
