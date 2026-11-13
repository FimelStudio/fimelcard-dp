data modify storage avalon:ballot code set value 30
data modify storage avalon:ballot label set value "任务成功 · 按Q表决"
data modify storage avalon:ballot color set value "green"
data modify storage avalon:ballot item set value "lime_dye"
data modify storage avalon:ballot slot set value "hotbar.0"
function avalon:player/give_ballot with storage avalon:ballot
data modify storage avalon:ballot code set value 31
data modify storage avalon:ballot label set value "任务失败 · 按Q表决"
data modify storage avalon:ballot color set value "red"
data modify storage avalon:ballot item set value "red_dye"
data modify storage avalon:ballot slot set value "hotbar.1"
function avalon:player/give_ballot with storage avalon:ballot
tellraw @s {text:"丢出绿/红染料完成表决，提交后两枚染料一起回收。",color:"yellow"}
tellraw @s {text:"好人只能提交成功；坏人可以选择成功或失败。",color:"gray"}
