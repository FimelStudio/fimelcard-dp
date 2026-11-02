# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s sp_panel 6
function splendor:ui/begin
data modify storage splendor:ui title set value "璀璨宝石 · 玩家资产"
data modify storage splendor:ui detail set value {text:"",extra:[]}
execute if data entity @e[tag=sp.current,limit=1] data.splendor.p1.name run function splendor:ui/public_player {side:1}
execute if data entity @e[tag=sp.current,limit=1] data.splendor.p2.name run function splendor:ui/public_player {side:2}
execute if data entity @e[tag=sp.current,limit=1] data.splendor.p3.name run function splendor:ui/public_player {side:3}
execute if data entity @e[tag=sp.current,limit=1] data.splendor.p4.name run function splendor:ui/public_player {side:4}
function splendor:ui/button {"code":1,"label":"返回菜单","color":"white"}
function splendor:ui/show with storage splendor:ui
