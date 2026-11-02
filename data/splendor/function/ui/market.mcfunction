# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s sp_panel 4
function splendor:ui/begin
data modify storage splendor:ui title set value "璀璨宝石 · 开发卡市场"
data modify storage splendor:ui picture set value {text:"\n\n\n\n\n\n",extra:[]}
function splendor:ui/market_slot {slot:0,code:100}
function splendor:ui/market_slot {slot:1,code:101}
function splendor:ui/market_slot {slot:2,code:102}
function splendor:ui/market_slot {slot:3,code:103}
data modify storage splendor:ui picture.extra append value {text:"\n\n\n\n\n\n\n\n"}
function splendor:ui/market_slot {slot:4,code:104}
function splendor:ui/market_slot {slot:5,code:105}
function splendor:ui/market_slot {slot:6,code:106}
function splendor:ui/market_slot {slot:7,code:107}
data modify storage splendor:ui picture.extra append value {text:"\n\n\n\n\n\n\n\n"}
function splendor:ui/market_slot {slot:8,code:108}
function splendor:ui/market_slot {slot:9,code:109}
function splendor:ui/market_slot {slot:10,code:110}
function splendor:ui/market_slot {slot:11,code:111}
data modify storage splendor:ui detail set value {text:"点击牌面查看费用、购买或预约；空位表示该级牌堆已用完。",color:"gray"}
function splendor:ui/button {"code":1,"label":"返回菜单","color":"white"}
function splendor:ui/show with storage splendor:ui
