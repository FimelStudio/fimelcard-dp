# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s sp_panel 5
function splendor:ui/begin
data modify storage splendor:ui title set value "璀璨宝石 · 我的预约牌"
data modify storage splendor:ui picture set value {text:"\n\n\n\n\n\n",extra:[]}
execute unless data storage splendor:ui hand.reserve[0] run data modify storage splendor:ui picture set value {text:"暂无预约牌",color:"gray"}
execute if data storage splendor:ui hand.reserve[0] run function splendor:ui/reserve_slot {index:0,code:120}
execute if data storage splendor:ui hand.reserve[1] run function splendor:ui/reserve_slot {index:1,code:121}
execute if data storage splendor:ui hand.reserve[2] run function splendor:ui/reserve_slot {index:2,code:122}
data modify storage splendor:ui detail set value {text:"预约牌仅本人可见。最多3张，不能丢弃；购买后释放预约位。",color:"gray"}
function splendor:ui/button {"code":1,"label":"返回菜单","color":"white"}
function splendor:ui/show with storage splendor:ui
