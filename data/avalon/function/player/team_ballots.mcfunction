data modify storage avalon:ballot code set value 20
data modify storage avalon:ballot label set value "同意组队 · 按Q表决"
data modify storage avalon:ballot color set value "green"
data modify storage avalon:ballot item set value "lime_dye"
data modify storage avalon:ballot slot set value "hotbar.0"
function avalon:player/give_ballot with storage avalon:ballot
data modify storage avalon:ballot code set value 21
data modify storage avalon:ballot label set value "反对组队 · 按Q表决"
data modify storage avalon:ballot color set value "red"
data modify storage avalon:ballot item set value "red_dye"
data modify storage avalon:ballot slot set value "hotbar.1"
function avalon:player/give_ballot with storage avalon:ballot
tellraw @s {text:"丢出绿/红染料完成表决，提交后两枚染料一起回收。",color:"yellow"}
