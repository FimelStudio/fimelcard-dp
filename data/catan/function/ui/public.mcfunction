# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if data entity @s data.catan.p1.name run function catan:ui/public_player {side:1,label:"红",color:"red"}
execute if data entity @s data.catan.p2.name run function catan:ui/public_player {side:2,label:"蓝",color:"blue"}
execute if data entity @s data.catan.p3.name run function catan:ui/public_player {side:3,label:"白",color:"white"}
execute if data entity @s data.catan.p4.name run function catan:ui/public_player {side:4,label:"橙",color:"gold"}
