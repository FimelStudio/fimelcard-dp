execute if data storage magical_athlete:engine s.pending.options[0] run return 0
execute unless data storage magical_athlete:engine s.queue[0] run return 0
execute unless score #budget ma_ctx matches 1.. run return 0
scoreboard players remove #budget ma_ctx 1
data modify storage magical_athlete:engine job set from storage magical_athlete:engine s.queue[0]
data remove storage magical_athlete:engine s.queue[0]
function magical_athlete:engine/cache
function magical_athlete:engine/powers
function magical_athlete:engine/copy_interrupt
execute if data storage magical_athlete:engine s.pending.options[0] run data modify storage magical_athlete:engine s.queue prepend from storage magical_athlete:engine job
execute if data storage magical_athlete:engine s.pending.options[0] run return 0
function magical_athlete:engine/job_dispatch
execute if data storage magical_athlete:engine s.pending.options[0] run return 0
execute if data storage magical_athlete:engine s.queue[0] run function magical_athlete:engine/drain_loop
