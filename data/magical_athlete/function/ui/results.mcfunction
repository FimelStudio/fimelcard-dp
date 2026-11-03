# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
data modify storage magical_athlete:ui detail.extra append value {text:"本场积分已结算。查看队伍积分后，任意玩家可进入下一场；尚未参赛的队员继续留队。",color:"yellow"}
function magical_athlete:ui/button {"code":5,"label":"进入下一场","color":"green"}
