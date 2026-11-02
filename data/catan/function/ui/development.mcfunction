function catan:ui/begin
scoreboard players set @s ca_panel 4
data modify storage catan:ui title set value "卡坦岛 · 开发牌"
data modify storage catan:ui columns set value 2
data modify storage catan:ui old0 set from storage catan:ui hand.dev[0]
data modify storage catan:ui old1 set from storage catan:ui hand.dev[1]
data modify storage catan:ui old2 set from storage catan:ui hand.dev[2]
data modify storage catan:ui old3 set from storage catan:ui hand.dev[3]
data modify storage catan:ui old4 set from storage catan:ui hand.dev[4]
data modify storage catan:ui new0 set from storage catan:ui hand.fresh[0]
data modify storage catan:ui new1 set from storage catan:ui hand.fresh[1]
data modify storage catan:ui new2 set from storage catan:ui hand.fresh[2]
data modify storage catan:ui new3 set from storage catan:ui hand.fresh[3]
data modify storage catan:ui new4 set from storage catan:ui hand.fresh[4]
function catan:ui/development_note with storage catan:ui
function catan:ui/icon_button {"code":600,"label":"骑士","color":"aqua","icon":""}
function catan:ui/icon_button {"code":601,"label":"修路","color":"aqua","icon":""}
function catan:ui/icon_button {"code":602,"label":"垄断","color":"aqua","icon":""}
function catan:ui/icon_button {"code":603,"label":"发明","color":"aqua","icon":""}
function catan:ui/show with storage catan:ui
