function catan:ui/begin
scoreboard players set @s ca_panel 1
data modify storage catan:ui title set value "卡坦岛 · 确认位置"
execute store result storage catan:ui target int 1 run scoreboard players get @s ca_pick
data modify storage catan:ui note set value {text:"金色标记为目标位置。确认后按规则扣除费用。",color:"aqua"}
function catan:ui/button {"code":300,"label":"确认放置","color":"green"}
function catan:ui/button {"code":100,"label":"重新瞄准","color":"yellow"}
function catan:ui/show with storage catan:ui
