scoreboard players set #ok ma_ctx 0
execute if score @s ct_paused matches 1 run return run function magical_athlete:engine/error {id:13}
execute unless data entity @s data.magical_athlete{version:1} run return run function magical_athlete:engine/error {id:1}
function magical_athlete:engine/context
data modify storage magical_athlete:engine request set value {actor:0,code:0,target:-1,epoch:-1}
data modify storage magical_athlete:engine request merge from storage magical_athlete:action input
data modify storage magical_athlete:engine normalized set from storage magical_athlete:engine request
scoreboard players set #actor ma_ctx -999
execute store result score #actor ma_ctx run data get storage magical_athlete:engine request.actor
execute store result storage magical_athlete:engine normalized.actor int 1 run scoreboard players get #actor ma_ctx
scoreboard players set #code ma_ctx -999
execute store result score #code ma_ctx run data get storage magical_athlete:engine request.code
execute store result storage magical_athlete:engine normalized.code int 1 run scoreboard players get #code ma_ctx
scoreboard players set #target ma_ctx -999
execute store result score #target ma_ctx run data get storage magical_athlete:engine request.target
execute store result storage magical_athlete:engine normalized.target int 1 run scoreboard players get #target ma_ctx
scoreboard players set #given_epoch ma_ctx -999
execute store result score #given_epoch ma_ctx run data get storage magical_athlete:engine request.epoch
execute store result storage magical_athlete:engine normalized.epoch int 1 run scoreboard players get #given_epoch ma_ctx
execute store success score #different ma_ctx run data modify storage magical_athlete:engine normalized set from storage magical_athlete:engine request
execute if score #different ma_ctx matches 1 run return run function magical_athlete:engine/error {id:10}
execute unless score #actor ma_ctx matches 1..6 run return run function magical_athlete:engine/error {id:2}
execute if score #actor ma_ctx > #n ma_ctx run return run function magical_athlete:engine/error {id:2}
execute unless score #given_epoch ma_ctx = #epoch ma_ctx run return run function magical_athlete:engine/error {id:3}
execute if score #phase ma_ctx matches 5 run return run function magical_athlete:engine/error {id:5}
data modify storage magical_athlete:engine s.events set value []
execute unless score #code ma_ctx matches 4 run data modify storage magical_athlete:engine s.seen set value []
scoreboard players set #ok ma_ctx 0
execute unless score #code ma_ctx matches 4 run data modify storage magical_athlete:engine s.copy_locks set value [0,0,0,0,0,0]
function magical_athlete:engine/dispatch
execute unless score #ok ma_ctx matches 1 run return 0
function magical_athlete:engine/drain
function magical_athlete:engine/advance_epoch
function magical_athlete:engine/commit
