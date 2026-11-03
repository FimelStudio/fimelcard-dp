# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if entity @e[tag=ma.current,scores={ma_state=1},limit=1] run return run function magical_athlete:ui/draft
execute if entity @e[tag=ma.current,scores={ma_state=2},limit=1] run return run function magical_athlete:ui/lineup
execute if entity @e[tag=ma.current,scores={ma_state=4},limit=1] run return run function magical_athlete:ui/results
execute if score @s ma_side = @e[tag=ma.current,limit=1] ma_pending run return run function magical_athlete:ui/pending
execute if score @s ma_side = @e[tag=ma.current,limit=1] ma_turn run return run function magical_athlete:ui/start_pawn
data modify storage magical_athlete:ui detail.extra append value {text:"等待其他队伍行动。",color:"gray"}
