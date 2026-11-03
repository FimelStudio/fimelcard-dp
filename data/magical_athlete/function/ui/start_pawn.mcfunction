# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.queue[0] run return 0
data modify storage magical_athlete:ui detail.extra append value {text:"请选择本回合行动的选手。技能、投骰及其连锁全部结算后才轮到下一位。\n",color:"yellow"}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[0] run function magical_athlete:ui/pawn_button {index:0}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[1] run function magical_athlete:ui/pawn_button {index:1}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[2] run function magical_athlete:ui/pawn_button {index:2}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[3] run function magical_athlete:ui/pawn_button {index:3}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[4] run function magical_athlete:ui/pawn_button {index:4}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[5] run function magical_athlete:ui/pawn_button {index:5}
