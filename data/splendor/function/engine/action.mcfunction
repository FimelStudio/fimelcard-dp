scoreboard players set #ok sp_ctx 0
scoreboard players set #error sp_ctx 1
execute if score @s ct_paused matches 1 run return run function splendor:engine/error {id:13}
execute unless data entity @s data.splendor{version:1} run return run function splendor:engine/error {id:1}
function splendor:engine/context
data modify storage splendor:engine request set value {actor:0,code:0,target:-1,epoch:-1,take:[0,0,0,0,0,0],pay:[0,0,0,0,0,0]}
data modify storage splendor:engine request merge from storage splendor:action input
data modify storage splendor:engine normalized set from storage splendor:engine request
scoreboard players set #actor sp_ctx -999
execute store result score #actor sp_ctx run data get storage splendor:engine request.actor
execute store result storage splendor:engine normalized.actor int 1 run scoreboard players get #actor sp_ctx
scoreboard players set #code sp_ctx -999
execute store result score #code sp_ctx run data get storage splendor:engine request.code
execute store result storage splendor:engine normalized.code int 1 run scoreboard players get #code sp_ctx
scoreboard players set #target sp_ctx -999
execute store result score #target sp_ctx run data get storage splendor:engine request.target
execute store result storage splendor:engine normalized.target int 1 run scoreboard players get #target sp_ctx
scoreboard players set #given_epoch sp_ctx -999
execute store result score #given_epoch sp_ctx run data get storage splendor:engine request.epoch
execute store result storage splendor:engine normalized.epoch int 1 run scoreboard players get #given_epoch sp_ctx
execute store result score #length sp_ctx run data get storage splendor:engine request.take
execute unless score #length sp_ctx matches 6 run return run function splendor:engine/error {id:10}
scoreboard players set #take0 sp_ctx -999
execute store result score #take0 sp_ctx run data get storage splendor:engine request.take[0]
execute unless score #take0 sp_ctx matches 0..10 run return run function splendor:engine/error {id:10}
execute store result storage splendor:engine normalized.take[0] int 1 run scoreboard players get #take0 sp_ctx
scoreboard players set #take1 sp_ctx -999
execute store result score #take1 sp_ctx run data get storage splendor:engine request.take[1]
execute unless score #take1 sp_ctx matches 0..10 run return run function splendor:engine/error {id:10}
execute store result storage splendor:engine normalized.take[1] int 1 run scoreboard players get #take1 sp_ctx
scoreboard players set #take2 sp_ctx -999
execute store result score #take2 sp_ctx run data get storage splendor:engine request.take[2]
execute unless score #take2 sp_ctx matches 0..10 run return run function splendor:engine/error {id:10}
execute store result storage splendor:engine normalized.take[2] int 1 run scoreboard players get #take2 sp_ctx
scoreboard players set #take3 sp_ctx -999
execute store result score #take3 sp_ctx run data get storage splendor:engine request.take[3]
execute unless score #take3 sp_ctx matches 0..10 run return run function splendor:engine/error {id:10}
execute store result storage splendor:engine normalized.take[3] int 1 run scoreboard players get #take3 sp_ctx
scoreboard players set #take4 sp_ctx -999
execute store result score #take4 sp_ctx run data get storage splendor:engine request.take[4]
execute unless score #take4 sp_ctx matches 0..10 run return run function splendor:engine/error {id:10}
execute store result storage splendor:engine normalized.take[4] int 1 run scoreboard players get #take4 sp_ctx
scoreboard players set #take5 sp_ctx -999
execute store result score #take5 sp_ctx run data get storage splendor:engine request.take[5]
execute unless score #take5 sp_ctx matches 0..10 run return run function splendor:engine/error {id:10}
execute store result storage splendor:engine normalized.take[5] int 1 run scoreboard players get #take5 sp_ctx
execute store result score #length sp_ctx run data get storage splendor:engine request.pay
execute unless score #length sp_ctx matches 6 run return run function splendor:engine/error {id:10}
scoreboard players set #pay0 sp_ctx -999
execute store result score #pay0 sp_ctx run data get storage splendor:engine request.pay[0]
execute unless score #pay0 sp_ctx matches 0..10 run return run function splendor:engine/error {id:10}
execute store result storage splendor:engine normalized.pay[0] int 1 run scoreboard players get #pay0 sp_ctx
scoreboard players set #pay1 sp_ctx -999
execute store result score #pay1 sp_ctx run data get storage splendor:engine request.pay[1]
execute unless score #pay1 sp_ctx matches 0..10 run return run function splendor:engine/error {id:10}
execute store result storage splendor:engine normalized.pay[1] int 1 run scoreboard players get #pay1 sp_ctx
scoreboard players set #pay2 sp_ctx -999
execute store result score #pay2 sp_ctx run data get storage splendor:engine request.pay[2]
execute unless score #pay2 sp_ctx matches 0..10 run return run function splendor:engine/error {id:10}
execute store result storage splendor:engine normalized.pay[2] int 1 run scoreboard players get #pay2 sp_ctx
scoreboard players set #pay3 sp_ctx -999
execute store result score #pay3 sp_ctx run data get storage splendor:engine request.pay[3]
execute unless score #pay3 sp_ctx matches 0..10 run return run function splendor:engine/error {id:10}
execute store result storage splendor:engine normalized.pay[3] int 1 run scoreboard players get #pay3 sp_ctx
scoreboard players set #pay4 sp_ctx -999
execute store result score #pay4 sp_ctx run data get storage splendor:engine request.pay[4]
execute unless score #pay4 sp_ctx matches 0..10 run return run function splendor:engine/error {id:10}
execute store result storage splendor:engine normalized.pay[4] int 1 run scoreboard players get #pay4 sp_ctx
scoreboard players set #pay5 sp_ctx -999
execute store result score #pay5 sp_ctx run data get storage splendor:engine request.pay[5]
execute unless score #pay5 sp_ctx matches 0..10 run return run function splendor:engine/error {id:10}
execute store result storage splendor:engine normalized.pay[5] int 1 run scoreboard players get #pay5 sp_ctx
execute store success score #different sp_ctx run data modify storage splendor:engine normalized set from storage splendor:engine request
execute if score #different sp_ctx matches 1 run return run function splendor:engine/error {id:10}
execute unless score #actor sp_ctx matches 1..4 run return run function splendor:engine/error {id:2}
execute if score #actor sp_ctx > #n sp_ctx run return run function splendor:engine/error {id:2}
execute unless score #given_epoch sp_ctx = #epoch sp_ctx run return run function splendor:engine/error {id:3}
execute unless score #actor sp_ctx = #turn sp_ctx run return run function splendor:engine/error {id:4}
execute if score #phase sp_ctx matches 4 run return run function splendor:engine/error {id:5}
function splendor:engine/load_actor with storage splendor:engine request
data modify storage splendor:engine state.last set value {code:0,actor:0,target:-1,card:-1,take:[0,0,0,0,0,0],pay:[0,0,0,0,0,0],noble:-1}
data modify storage splendor:engine state.last.code set from storage splendor:engine request.code
data modify storage splendor:engine state.last.actor set from storage splendor:engine request.actor
data modify storage splendor:engine state.last.target set from storage splendor:engine request.target
function splendor:engine/dispatch
execute unless score #ok sp_ctx matches 1 run return 0
function splendor:engine/commit
return 1
