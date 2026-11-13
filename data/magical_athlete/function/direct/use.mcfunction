function magical_athlete:input/context
execute unless entity @s[tag=ma.actor] run return 0
$data modify storage magical_athlete:direct hit set value {table:$(table),epoch:$(epoch),type:$(type),id:$(id)}
$execute unless score @s ma_table matches $(table) run return 0
$execute unless score @e[tag=ma.current,limit=1] ma_epoch matches $(epoch) run return run function magical_athlete:direct/stale
$scoreboard players set #hit_type ma_ctx $(type)
$scoreboard players set #hit_id ma_ctx $(id)
execute if score #hit_type ma_ctx matches 1 unless score @s ma_side = @e[tag=ma.current,limit=1] ma_turn run return run function magical_athlete:direct/roster_info with storage magical_athlete:direct hit
execute if score #hit_type ma_ctx matches 1 run scoreboard players operation #code ma_ctx = #hit_id ma_ctx
execute if score #hit_type ma_ctx matches 1 run scoreboard players add #code ma_ctx 100
execute if score #hit_type ma_ctx matches 1 run return run function magical_athlete:direct/confirm
execute if score #hit_type ma_ctx matches 2 unless score @s ma_side = @e[tag=ma.current,limit=1] ma_pending run return run function magical_athlete:direct/pawn_info with storage magical_athlete:direct hit
execute unless score @s ma_side = @e[tag=ma.current,limit=1] ma_pending run return run function magical_athlete:direct/wait
data modify storage magical_athlete:direct pending set from entity @e[tag=ma.current,limit=1] data.magical_athlete.pending
scoreboard players set #target_skill ma_ctx 0
execute if data storage magical_athlete:direct pending{kind:"hypnotist"} run scoreboard players set #target_skill ma_ctx 1
execute if data storage magical_athlete:direct pending{kind:"flip"} run scoreboard players set #target_skill ma_ctx 1
execute if data storage magical_athlete:direct pending{kind:"duel"} run scoreboard players set #target_skill ma_ctx 1
execute if data storage magical_athlete:direct pending{kind:"mastermind"} run scoreboard players set #target_skill ma_ctx 1
execute if data storage magical_athlete:direct pending{kind:"copycat"} run scoreboard players set #target_skill ma_ctx 1
execute if score #hit_type ma_ctx matches 2 if data storage magical_athlete:direct pending{kind:"thirdwheel"} run return run function magical_athlete:direct/pawn_cell with storage magical_athlete:direct hit
execute if score #hit_type ma_ctx matches 2 unless score #target_skill ma_ctx matches 1 run return run function magical_athlete:direct/pawn_info with storage magical_athlete:direct hit
execute if score #hit_type ma_ctx matches 3 unless data storage magical_athlete:direct pending{kind:"thirdwheel"} run return 0
$execute unless data storage magical_athlete:direct pending{options:[$(id)]} run return run function magical_athlete:direct/target_error
scoreboard players operation #code ma_ctx = #hit_id ma_ctx
scoreboard players add #code ma_ctx 2100
function magical_athlete:direct/confirm
