# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage magical_athlete:ui public set value {text:"第$(round)／4场 · ",color:"gold",extra:[]}
$data modify storage magical_athlete:ui public.extra append from entity @s data.magical_athlete.p$(turn).name
execute if score @s ma_state matches 1 run data modify storage magical_athlete:ui public.extra append value {text:" 选角中",color:"yellow"}
execute if score @s ma_state matches 2 run data modify storage magical_athlete:ui public.extra append value {text:" · 各队秘密选择参赛选手",color:"yellow"}
execute if score @s ma_state matches 3 run data modify storage magical_athlete:ui public.extra append value {text:" 行动中",color:"yellow"}
execute if score @s ma_state matches 4 run data modify storage magical_athlete:ui public.extra append value {text:" · 本场已结束",color:"green"}
execute if score @s ma_state matches 5 run data modify storage magical_athlete:ui public.extra append value {text:" · 全场已结束",color:"green"}
execute if data entity @s data.magical_athlete{track:0} run data modify storage magical_athlete:ui public.extra append value {text:" · 普通跑道",color:"gray"}
execute if data entity @s data.magical_athlete{track:1} run data modify storage magical_athlete:ui public.extra append value {text:" · 狂野跑道",color:"red"}
