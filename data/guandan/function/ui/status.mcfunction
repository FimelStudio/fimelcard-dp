data modify storage guandan:ui level set value "2"
execute if score @e[tag=gd.current,limit=1] gd_level matches 2 run data modify storage guandan:ui level set value "2"
execute if score @e[tag=gd.current,limit=1] gd_level matches 3 run data modify storage guandan:ui level set value "3"
execute if score @e[tag=gd.current,limit=1] gd_level matches 4 run data modify storage guandan:ui level set value "4"
execute if score @e[tag=gd.current,limit=1] gd_level matches 5 run data modify storage guandan:ui level set value "5"
execute if score @e[tag=gd.current,limit=1] gd_level matches 6 run data modify storage guandan:ui level set value "6"
execute if score @e[tag=gd.current,limit=1] gd_level matches 7 run data modify storage guandan:ui level set value "7"
execute if score @e[tag=gd.current,limit=1] gd_level matches 8 run data modify storage guandan:ui level set value "8"
execute if score @e[tag=gd.current,limit=1] gd_level matches 9 run data modify storage guandan:ui level set value "9"
execute if score @e[tag=gd.current,limit=1] gd_level matches 10 run data modify storage guandan:ui level set value "10"
execute if score @e[tag=gd.current,limit=1] gd_level matches 11 run data modify storage guandan:ui level set value "J"
execute if score @e[tag=gd.current,limit=1] gd_level matches 12 run data modify storage guandan:ui level set value "Q"
execute if score @e[tag=gd.current,limit=1] gd_level matches 13 run data modify storage guandan:ui level set value "K"
execute if score @e[tag=gd.current,limit=1] gd_level matches 14 run data modify storage guandan:ui level set value "A"
function guandan:ui/level_info with storage guandan:ui
execute if entity @e[tag=gd.current,scores={gd_state=1},limit=1] run data modify storage guandan:ui phase set value {text:"正在发牌。",color:"gray"}
execute if entity @e[tag=gd.current,scores={gd_state=2,gd_phase=1},limit=1] run data modify storage guandan:ui phase set value {text:"贡牌：选择除逢人配外最大的牌。",color:"yellow"}
execute if entity @e[tag=gd.current,scores={gd_state=2,gd_phase=2},limit=1] run data modify storage guandan:ui phase set value {text:"还牌：选择不大于10的牌；没有时还最小牌。",color:"yellow"}
execute if entity @e[tag=gd.current,scores={gd_state=3},limit=1] if score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run data modify storage guandan:ui phase set value {text:"轮到你出牌。",color:"green"}
execute if entity @e[tag=gd.me,scores={gd_rank=1..},limit=1] run data modify storage guandan:ui phase set value {text:"你已出完手牌，等待本副结算。",color:"gold"}
execute if entity @e[tag=gd.current,scores={gd_state=4},limit=1] run data modify storage guandan:ui phase set value {text:"本副结算。",color:"gold"}
execute if entity @e[tag=gd.current,scores={gd_state=5},limit=1] run data modify storage guandan:ui phase set value {text:"整场结束。",color:"gold"}
