# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function magical_athlete:input/context
execute unless entity @s[tag=ma.actor] run return 0
function magical_athlete:ui/begin
execute if entity @e[tag=ma.current,scores={ma_anim=1..},limit=1] run data modify storage magical_athlete:ui detail.extra append value {text:"正在播放比赛动画……",color:"gray"}
execute if entity @e[tag=ma.current,scores={ma_anim=0},limit=1] run function magical_athlete:ui/phase
function magical_athlete:ui/button {"code":6,"label":"我的队员","color":"aqua"}
function magical_athlete:ui/button {"code":7,"label":"比赛与积分","color":"aqua"}
function magical_athlete:ui/button {"code":8,"label":"游戏规则","color":"gray"}
function magical_athlete:ui/button {"code":9,"label":"音乐开关","color":"gray"}
function magical_athlete:ui/show with storage magical_athlete:ui
