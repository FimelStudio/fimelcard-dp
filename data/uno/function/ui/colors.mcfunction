# 万能牌的选色按钮携带原窗口epoch；后续回合无法提交。
scoreboard players operation @s un_colorpick = @s un_pick
data modify storage uno:ui colors set value []
scoreboard players set #ui_colorcode un_ctx 200
execute if score #ui_action un_ctx matches 2 run scoreboard players set #ui_colorcode un_ctx 210
scoreboard players operation #ui_colorcode un_ctx += #ui_base un_ctx
function uno:ui/color_button {name:"红",color:"red"}
scoreboard players add #ui_colorcode un_ctx 1
function uno:ui/color_button {name:"黄",color:"yellow"}
scoreboard players add #ui_colorcode un_ctx 1
function uno:ui/color_button {name:"绿",color:"green"}
scoreboard players add #ui_colorcode un_ctx 1
function uno:ui/color_button {name:"蓝",color:"blue"}
function uno:ui/colors_show with storage uno:ui
scoreboard players enable @s un_action
tag @a[tag=un.actor] remove un.actor
