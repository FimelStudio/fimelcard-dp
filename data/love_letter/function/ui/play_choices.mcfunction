data modify storage love_letter:ui phase set value {text:"选择一张牌，点击出牌。",color:"green"}
execute if score @s ll_pick matches 0..1 run function love_letter:ui/button {code:20,label:"出牌",color:"green"}
execute if entity @e[tag=ll.me,scores={ll_hand=8,ll_extra=5},limit=1] run data modify storage love_letter:ui phase set value {text:"本回合必须打出伯爵夫人。",color:"yellow"}
execute if entity @e[tag=ll.me,scores={ll_hand=8,ll_extra=7},limit=1] run data modify storage love_letter:ui phase set value {text:"本回合必须打出伯爵夫人。",color:"yellow"}
execute if entity @e[tag=ll.me,scores={ll_extra=8,ll_hand=5},limit=1] run data modify storage love_letter:ui phase set value {text:"本回合必须打出伯爵夫人。",color:"yellow"}
execute if entity @e[tag=ll.me,scores={ll_extra=8,ll_hand=7},limit=1] run data modify storage love_letter:ui phase set value {text:"本回合必须打出伯爵夫人。",color:"yellow"}
