execute store result score #n ma_ctx run data get storage magical_athlete:engine s.n
data modify storage magical_athlete:engine s.pool set value []
data modify storage magical_athlete:engine s.draft_order set value []
scoreboard players set #count ma_ctx 0
scoreboard players operation #count ma_ctx = #n ma_ctx
scoreboard players operation #count ma_ctx += #n ma_ctx
execute if score #n ma_ctx matches 2 run scoreboard players set #count ma_ctx 8
function magical_athlete:engine/draft/deal
execute store result score #first ma_ctx run data get storage magical_athlete:engine s.draft_first
execute store result score #batch ma_ctx run data get storage magical_athlete:engine s.draft_batch
execute if score #batch ma_ctx matches 2 run scoreboard players add #first ma_ctx 1
execute if score #first ma_ctx > #n ma_ctx run scoreboard players set #first ma_ctx 1
function magical_athlete:engine/draft/order
data modify storage magical_athlete:engine s.draft_at set value 0
data modify storage magical_athlete:engine s.turn set from storage magical_athlete:engine s.draft_order[0]
execute store result score #draft ma_ctx run data get storage magical_athlete:engine s.draft_mode
execute if score #draft ma_ctx matches 1 run function magical_athlete:engine/draft/random
