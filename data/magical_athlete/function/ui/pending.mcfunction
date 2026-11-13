# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
data modify storage magical_athlete:ui pending set from entity @e[tag=ma.current,limit=1] data.magical_athlete.pending
data modify storage magical_athlete:ui title set value "胡闹运动会 · 选手技能"
function magical_athlete:ui/pending_description with storage magical_athlete:ui pending
execute if data storage magical_athlete:ui pending.options[0] run function magical_athlete:ui/option {index:0}
execute if data storage magical_athlete:ui pending.options[1] run function magical_athlete:ui/option {index:1}
execute if data storage magical_athlete:ui pending.options[2] run function magical_athlete:ui/option {index:2}
execute if data storage magical_athlete:ui pending.options[3] run function magical_athlete:ui/option {index:3}
execute if data storage magical_athlete:ui pending.options[4] run function magical_athlete:ui/option {index:4}
execute if data storage magical_athlete:ui pending.options[5] run function magical_athlete:ui/option {index:5}
execute if data storage magical_athlete:ui pending.options[6] run function magical_athlete:ui/option {index:6}
execute if data storage magical_athlete:ui pending.options[7] run function magical_athlete:ui/option {index:7}
execute if data storage magical_athlete:ui pending.options[8] run function magical_athlete:ui/option {index:8}
execute if data storage magical_athlete:ui pending.options[9] run function magical_athlete:ui/option {index:9}
execute if data storage magical_athlete:ui pending.options[10] run function magical_athlete:ui/option {index:10}
execute if data storage magical_athlete:ui pending.options[11] run function magical_athlete:ui/option {index:11}
execute if data storage magical_athlete:ui pending.options[12] run function magical_athlete:ui/option {index:12}
execute if data storage magical_athlete:ui pending.options[13] run function magical_athlete:ui/option {index:13}
execute if data storage magical_athlete:ui pending.options[14] run function magical_athlete:ui/option {index:14}
execute if data storage magical_athlete:ui pending.options[15] run function magical_athlete:ui/option {index:15}
execute if data storage magical_athlete:ui pending.options[16] run function magical_athlete:ui/option {index:16}
execute if data storage magical_athlete:ui pending.options[17] run function magical_athlete:ui/option {index:17}
execute if data storage magical_athlete:ui pending.options[18] run function magical_athlete:ui/option {index:18}
execute if data storage magical_athlete:ui pending.options[19] run function magical_athlete:ui/option {index:19}
execute if data storage magical_athlete:ui pending.options[20] run function magical_athlete:ui/option {index:20}
execute if data storage magical_athlete:ui pending.options[21] run function magical_athlete:ui/option {index:21}
execute if data storage magical_athlete:ui pending.options[22] run function magical_athlete:ui/option {index:22}
execute if data storage magical_athlete:ui pending.options[23] run function magical_athlete:ui/option {index:23}
execute if data storage magical_athlete:ui pending.options[24] run function magical_athlete:ui/option {index:24}
execute if data storage magical_athlete:ui pending.options[25] run function magical_athlete:ui/option {index:25}
execute if data storage magical_athlete:ui pending.options[26] run function magical_athlete:ui/option {index:26}
execute if data storage magical_athlete:ui pending.options[27] run function magical_athlete:ui/option {index:27}
execute if data storage magical_athlete:ui pending.options[28] run function magical_athlete:ui/option {index:28}
execute if data storage magical_athlete:ui pending.options[29] run function magical_athlete:ui/option {index:29}
execute if data storage magical_athlete:ui pending.options[30] run function magical_athlete:ui/option {index:30}
execute if data storage magical_athlete:ui pending.options[31] run function magical_athlete:ui/option {index:31}
execute if data storage magical_athlete:ui pending.options[32] run function magical_athlete:ui/option {index:32}
execute if data storage magical_athlete:ui pending.options[33] run function magical_athlete:ui/option {index:33}
execute if data storage magical_athlete:ui pending.options[34] run function magical_athlete:ui/option {index:34}
execute if data storage magical_athlete:ui pending.options[35] run function magical_athlete:ui/option {index:35}
