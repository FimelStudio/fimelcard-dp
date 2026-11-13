scoreboard players add @s ma_dpage 6
execute store result storage magical_athlete:ui side int 1 run scoreboard players get @s ma_side
function magical_athlete:ui/private with storage magical_athlete:ui
execute if entity @e[tag=ma.current,scores={ma_state=1},limit=1] run data modify storage magical_athlete:direct options set from entity @e[tag=ma.current,limit=1] data.magical_athlete.pool
execute if entity @e[tag=ma.current,scores={ma_state=2},limit=1] run data modify storage magical_athlete:direct options set from storage magical_athlete:ui hand.hand
execute if entity @e[tag=ma.current,scores={ma_state=3},limit=1] run data modify storage magical_athlete:direct options set from entity @e[tag=ma.current,limit=1] data.magical_athlete.pending.options
execute store result score #count ma_ctx run data get storage magical_athlete:direct options
execute if score @s ma_dpage >= #count ma_ctx run scoreboard players set @s ma_dpage 0
# 共享storage可能刚被另一桌更新；重新读取本人的阶段与候选列表。
execute if entity @e[tag=ma.current,scores={ma_state=1},limit=1] run return run function magical_athlete:direct/draft
execute if entity @e[tag=ma.current,scores={ma_state=2},limit=1] run return run function magical_athlete:direct/lineup
function magical_athlete:direct/choices
