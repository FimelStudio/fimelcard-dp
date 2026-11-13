# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function magical_athlete:ui/begin
data modify storage magical_athlete:ui title set value "胡闹运动会 · 比赛与积分"
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.p1.name run function magical_athlete:ui/team {side:1}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.p2.name run function magical_athlete:ui/team {side:2}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.p3.name run function magical_athlete:ui/team {side:3}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.p4.name run function magical_athlete:ui/team {side:4}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.p5.name run function magical_athlete:ui/team {side:5}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.p6.name run function magical_athlete:ui/team {side:6}
data modify storage magical_athlete:ui detail.extra append value {text:"\n当前跑道：\n",color:"gold"}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[0] run function magical_athlete:ui/public_racer {index:0}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[1] run function magical_athlete:ui/public_racer {index:1}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[2] run function magical_athlete:ui/public_racer {index:2}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[3] run function magical_athlete:ui/public_racer {index:3}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[4] run function magical_athlete:ui/public_racer {index:4}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[5] run function magical_athlete:ui/public_racer {index:5}
function magical_athlete:ui/button {"code":1,"label":"返回比赛菜单","color":"white"}
function magical_athlete:ui/show with storage magical_athlete:ui
