# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s sp_panel 8
function splendor:ui/begin
data modify storage splendor:ui title set value "璀璨宝石 · 盲抽预约"
data modify storage splendor:ui detail set value {text:"选定后预约该级牌堆顶牌，仅本人可见。最多预约3张；库存有黄金时同时领取1枚。",color:"gray"}
execute if data entity @e[tag=sp.current,limit=1] data.splendor.deck1[0] run function splendor:ui/button {"code":140,"label":"预约第1级牌堆","color":"gold"}
execute if data entity @e[tag=sp.current,limit=1] data.splendor.deck2[0] run function splendor:ui/button {"code":141,"label":"预约第2级牌堆","color":"gold"}
execute if data entity @e[tag=sp.current,limit=1] data.splendor.deck3[0] run function splendor:ui/button {"code":142,"label":"预约第3级牌堆","color":"gold"}
function splendor:ui/button {"code":1,"label":"返回菜单","color":"white"}
function splendor:ui/show with storage splendor:ui
