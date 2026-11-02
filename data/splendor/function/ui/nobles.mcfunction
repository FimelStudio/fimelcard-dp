# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s sp_panel 7
function splendor:ui/begin
data modify storage splendor:ui title set value "璀璨宝石 · 贵族"
data modify storage splendor:ui picture set value {text:"\n\n\n\n\n\n",extra:[]}
function splendor:ui/noble_slot {slot:0,label:1}
execute if score @s sp_side = @e[tag=sp.current,limit=1] sp_turn if entity @e[tag=sp.current,scores={sp_state=3},limit=1] if data entity @e[tag=sp.current,limit=1] data.splendor{eligible:[0]} run function splendor:ui/button {"code":160,"label":"选择第1位贵族","color":"green"}
function splendor:ui/noble_slot {slot:1,label:2}
execute if score @s sp_side = @e[tag=sp.current,limit=1] sp_turn if entity @e[tag=sp.current,scores={sp_state=3},limit=1] if data entity @e[tag=sp.current,limit=1] data.splendor{eligible:[1]} run function splendor:ui/button {"code":161,"label":"选择第2位贵族","color":"green"}
function splendor:ui/noble_slot {slot:2,label:3}
execute if score @s sp_side = @e[tag=sp.current,limit=1] sp_turn if entity @e[tag=sp.current,scores={sp_state=3},limit=1] if data entity @e[tag=sp.current,limit=1] data.splendor{eligible:[2]} run function splendor:ui/button {"code":162,"label":"选择第3位贵族","color":"green"}
function splendor:ui/noble_slot {slot:3,label:4}
execute if score @s sp_side = @e[tag=sp.current,limit=1] sp_turn if entity @e[tag=sp.current,scores={sp_state=3},limit=1] if data entity @e[tag=sp.current,limit=1] data.splendor{eligible:[3]} run function splendor:ui/button {"code":163,"label":"选择第4位贵族","color":"green"}
function splendor:ui/noble_slot {slot:4,label:5}
execute if score @s sp_side = @e[tag=sp.current,limit=1] sp_turn if entity @e[tag=sp.current,scores={sp_state=3},limit=1] if data entity @e[tag=sp.current,limit=1] data.splendor{eligible:[4]} run function splendor:ui/button {"code":164,"label":"选择第5位贵族","color":"green"}
data modify storage splendor:ui detail set value {text:"每位贵族3分，只看永久折扣，不消耗筹码。每回合最多来访一位；符合多位时由本人选择。",color:"gray"}
function splendor:ui/button {"code":1,"label":"返回菜单","color":"white"}
function splendor:ui/show with storage splendor:ui
