execute if score @s ma_finish matches 1.. run return 0
scoreboard players set @s ma_finish 100
function magical_athlete:sound/win
tellraw @a[tag=ma.audience] {text:"[胡闹运动会] 四场结束，积分最高的队伍获胜（同分共享胜利）。",color:"gold"}
execute if data entity @s data.magical_athlete.p1.name run function magical_athlete:game/score {side:1}
execute if data entity @s data.magical_athlete.p2.name run function magical_athlete:game/score {side:2}
execute if data entity @s data.magical_athlete.p3.name run function magical_athlete:game/score {side:3}
execute if data entity @s data.magical_athlete.p4.name run function magical_athlete:game/score {side:4}
execute if data entity @s data.magical_athlete.p5.name run function magical_athlete:game/score {side:5}
execute if data entity @s data.magical_athlete.p6.name run function magical_athlete:game/score {side:6}
execute if data entity @s data.magical_athlete{winners:[1]} run function magical_athlete:game/announce {side:1}
execute if data entity @s data.magical_athlete{winners:[2]} run function magical_athlete:game/announce {side:2}
execute if data entity @s data.magical_athlete{winners:[3]} run function magical_athlete:game/announce {side:3}
execute if data entity @s data.magical_athlete{winners:[4]} run function magical_athlete:game/announce {side:4}
execute if data entity @s data.magical_athlete{winners:[5]} run function magical_athlete:game/announce {side:5}
execute if data entity @s data.magical_athlete{winners:[6]} run function magical_athlete:game/announce {side:6}
