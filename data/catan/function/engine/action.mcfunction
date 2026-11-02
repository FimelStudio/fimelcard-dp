scoreboard players set #ok ca_ctx 0
scoreboard players set #error ca_ctx 9
scoreboard players set #changed ca_ctx 0
execute unless data entity @s data.catan{version:1} run return run function catan:engine/error {id:1}
function catan:engine/context
data modify storage catan:engine request set value {actor:0,code:0,target:-1,a:-1,b:-1,epoch:-1,offer:[0,0,0,0,0],want:[0,0,0,0,0]}
data modify storage catan:engine request merge from storage catan:action input
execute store result score #actor ca_ctx run data get storage catan:engine request.actor
execute store result score #code ca_ctx run data get storage catan:engine request.code
execute store result score #target ca_ctx run data get storage catan:engine request.target
execute store result score #a ca_ctx run data get storage catan:engine request.a
execute store result score #b ca_ctx run data get storage catan:engine request.b
execute store result score #given_epoch ca_ctx run data get storage catan:engine request.epoch
execute unless score #actor ca_ctx matches 1..4 run return run function catan:engine/error {id:2}
execute if score #actor ca_ctx > #n ca_ctx run return run function catan:engine/error {id:2}
execute unless score #given_epoch ca_ctx = #epoch ca_ctx run return run function catan:engine/error {id:3}
execute if score #phase ca_ctx matches 10..11 run return run function catan:engine/error {id:12}
function catan:engine/load_actor with storage catan:engine request
data modify storage catan:engine state.last set value {code:0,actor:0,target:-1,a:-1,b:-1,production:[]}
data modify storage catan:engine state.last.code set from storage catan:engine request.code
data modify storage catan:engine state.last.actor set from storage catan:engine request.actor
data modify storage catan:engine state.last.target set from storage catan:engine request.target
data modify storage catan:engine state.last.a set from storage catan:engine request.a
data modify storage catan:engine state.last.b set from storage catan:engine request.b
function catan:engine/dispatch
execute unless score #ok ca_ctx matches 1 run return 0
function catan:engine/commit
return 1
