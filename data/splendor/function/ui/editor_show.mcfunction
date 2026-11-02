# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function splendor:ui/begin
data modify storage splendor:ui title set value "璀璨宝石 · 选择筹码"
data modify storage splendor:ui detail set value {text:"",extra:[]}
execute if score @s sp_panel matches 3 run function splendor:ui/read_target
execute if score @s sp_panel matches 3 run function splendor:ui/card_picture with storage splendor:ui
execute if score @s sp_panel matches 1 run data modify storage splendor:ui detail.extra append value {text:"拿三颗异色（不足三色时拿剩余颜色），或同色两颗（拿前该堆至少4颗）。黄金只能预约获得。\n",color:"gray"}
execute if score @s sp_panel matches 2 run data modify storage splendor:ui detail.extra append value {text:"选择退回的筹码，恰好退到10颗；可以退本次刚拿到的筹码或黄金。\n",color:"yellow"}
execute if score @s sp_panel matches 3 run function splendor:ui/payment_summary
execute store result storage splendor:ui pick int 1 run scoreboard players get @s sp_pick0
function splendor:ui/editor_row {index:0,name:"钻石",minus:200,plus:201}
execute store result storage splendor:ui pick int 1 run scoreboard players get @s sp_pick1
function splendor:ui/editor_row {index:1,name:"蓝宝石",minus:202,plus:203}
execute store result storage splendor:ui pick int 1 run scoreboard players get @s sp_pick2
function splendor:ui/editor_row {index:2,name:"祖母绿",minus:204,plus:205}
execute store result storage splendor:ui pick int 1 run scoreboard players get @s sp_pick3
function splendor:ui/editor_row {index:3,name:"红宝石",minus:206,plus:207}
execute store result storage splendor:ui pick int 1 run scoreboard players get @s sp_pick4
function splendor:ui/editor_row {index:4,name:"缟玛瑙",minus:208,plus:209}
execute store result storage splendor:ui pick int 1 run scoreboard players get @s sp_pick5
function splendor:ui/editor_row {index:5,name:"黄金",minus:210,plus:211}
execute if score @s sp_panel matches 1 run function splendor:ui/button {"code":10,"label":"确认拿取","color":"green"}
execute if score @s sp_panel matches 2 run function splendor:ui/button {"code":11,"label":"确认退回","color":"green"}
execute if score @s sp_panel matches 3 run function splendor:ui/button {"code":12,"label":"确认购买","color":"green"}
execute if score @s sp_panel matches 3 if score @s sp_target matches 0..11 run function splendor:ui/button {"code":13,"label":"预约此牌","color":"gold"}
function splendor:ui/button {"code":1,"label":"返回菜单","color":"white"}
function splendor:ui/show with storage splendor:ui
