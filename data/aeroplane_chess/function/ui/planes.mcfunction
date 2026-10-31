data modify storage aeroplane_chess:ui status set value "选择一架飞机"
scoreboard players operation #ui_color ac_ctx = @s ac_color
execute as @e[tag=ac.board,scores={ac_plane=0,ac_legal=1}] if score @s ac_color = #ui_color ac_ctx run function aeroplane_chess:ui/button {code:2,label:"1 号飞机"}
execute as @e[tag=ac.board,scores={ac_plane=1,ac_legal=1}] if score @s ac_color = #ui_color ac_ctx run function aeroplane_chess:ui/button {code:3,label:"2 号飞机"}
execute as @e[tag=ac.board,scores={ac_plane=2,ac_legal=1}] if score @s ac_color = #ui_color ac_ctx run function aeroplane_chess:ui/button {code:4,label:"3 号飞机"}
execute as @e[tag=ac.board,scores={ac_plane=3,ac_legal=1}] if score @s ac_color = #ui_color ac_ctx run function aeroplane_chess:ui/button {code:5,label:"4 号飞机"}
