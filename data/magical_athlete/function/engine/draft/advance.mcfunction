execute store result score #at ma_ctx run data get storage magical_athlete:engine s.draft_at
scoreboard players add #at ma_ctx 1
execute store result storage magical_athlete:engine s.draft_at int 1 run scoreboard players get #at ma_ctx
execute store result storage magical_athlete:engine index.at int 1 run scoreboard players get #at ma_ctx
function magical_athlete:engine/draft/turn with storage magical_athlete:engine index
execute if data storage magical_athlete:engine s.pool[0] run return 0
execute store result score #batch ma_ctx run data get storage magical_athlete:engine s.draft_batch
execute if score #batch ma_ctx matches 1 run data modify storage magical_athlete:engine s.draft_batch set value 2
execute if score #batch ma_ctx matches 1 run return run function magical_athlete:engine/draft/init
data modify storage magical_athlete:engine s.phase set value 2
function magical_athlete:engine/rolloff
execute store result storage magical_athlete:engine s.turn int 1 run scoreboard players get #winner ma_ctx
