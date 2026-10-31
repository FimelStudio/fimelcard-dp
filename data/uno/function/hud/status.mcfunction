data modify storage fimel_title:io text set value {text:"UNO · ",color:"gold",shadow_color:0,extra:[]}
execute if score @e[tag=un.current,limit=1] un_state matches 1 run data modify storage fimel_title:io text.extra append value {text:"正在发牌",color:"yellow"}
execute if score @e[tag=un.current,limit=1] un_state matches 2 if score @s un_seat = @e[tag=un.current,limit=1] un_turn run data modify storage fimel_title:io text.extra append value {text:"轮到你",color:"green"}
execute if score @e[tag=un.current,limit=1] un_state matches 2 unless score @s un_seat = @e[tag=un.current,limit=1] un_turn run data modify storage fimel_title:io text.extra append value {text:"等待出牌",color:"gray"}
execute if score @e[tag=un.current,limit=1] un_state matches 3 run data modify storage fimel_title:io text.extra append value {text:"抓 UNO／补喊窗口",color:"yellow"}
execute if score @e[tag=un.current,limit=1] un_state matches 4 run data modify storage fimel_title:io text.extra append value {text:"等待接受／质疑 +4",color:"yellow"}
execute if score @e[tag=un.current,limit=1] un_state matches 5 run data modify storage fimel_title:io text.extra append value {text:"本局结束",color:"gold"}
data modify storage fimel_title:io text.extra append value {text:" · ",color:"dark_gray"}
execute if score @e[tag=un.current,limit=1] un_color matches 0 run data modify storage fimel_title:io text.extra append value {text:"红色",color:"red"}
execute if score @e[tag=un.current,limit=1] un_color matches 1 run data modify storage fimel_title:io text.extra append value {text:"黄色",color:"yellow"}
execute if score @e[tag=un.current,limit=1] un_color matches 2 run data modify storage fimel_title:io text.extra append value {text:"绿色",color:"green"}
execute if score @e[tag=un.current,limit=1] un_color matches 3 run data modify storage fimel_title:io text.extra append value {text:"蓝色",color:"blue"}
execute if score @e[tag=un.current,limit=1] un_dir matches 1 run data modify storage fimel_title:io text.extra append value {text:" · 顺时针",color:"gray"}
execute if score @e[tag=un.current,limit=1] un_dir matches -1 run data modify storage fimel_title:io text.extra append value {text:" · 逆时针",color:"gray"}
data modify storage fimel_title:io y set value 76.0d
execute if score #hud_types un_ctx matches 0 run data modify storage fimel_title:io y set value 36.0d
execute if score #hud_types un_ctx matches 19..36 run data modify storage fimel_title:io y set value 120.0d
execute if score #hud_types un_ctx matches 37..54 run data modify storage fimel_title:io y set value 152.0d
function uno:hud/text_default
