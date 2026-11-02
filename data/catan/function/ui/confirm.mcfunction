# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function catan:ui/begin
scoreboard players set @s ca_panel 1
data modify storage catan:ui title set value "卡坦岛 · 确认位置"
execute store result storage catan:ui target int 1 run scoreboard players get @s ca_pick
execute if score @s ca_mode matches 1 run data modify storage catan:ui note set value {"text":"金色标记为强盗目的地。确认移动，不消耗资源。","color":"aqua"}
execute if score @s ca_mode matches 2 run data modify storage catan:ui note set value {"text":"金色标记为村庄交点。费用：木材、砖块、羊毛、粮食各1。","color":"aqua"}
execute if score @s ca_mode matches 3 run data modify storage catan:ui note set value {"text":"金色标记为道路边。费用：木材、砖块各1。","color":"aqua"}
execute if score @s ca_mode matches 4 run data modify storage catan:ui note set value {"text":"金色标记为城市交点。须选己方村庄，费用：粮食2、矿石3。","color":"aqua"}
execute if entity @e[tag=ca.current,scores={ca_state=1..2},limit=1] run data modify storage catan:ui note set value {text:"金色标记为预选位置。初始布置免费，确认前不会放置。",color:"aqua"}
execute if entity @e[tag=ca.current,scores={ca_state=8},limit=1] run data modify storage catan:ui note set value {text:"金色标记为道路边。消耗一次修路卡机会，不扣资源。",color:"aqua"}
function catan:ui/button {"code":300,"label":"确认放置","color":"green"}
function catan:ui/button {"code":100,"label":"重新瞄准","color":"yellow"}
function catan:ui/show with storage catan:ui
