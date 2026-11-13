$execute store result score #old ca_ctx run data get storage catan:engine state.p$(actor).dev[0]
$execute store result score #new ca_ctx run data get storage catan:engine state.p$(actor).fresh[0]
scoreboard players operation #old ca_ctx += #new ca_ctx
$execute store result storage catan:engine state.p$(actor).dev[0] int 1 run scoreboard players get #old ca_ctx
$data modify storage catan:engine state.p$(actor).fresh[0] set value 0
$execute store result score #old ca_ctx run data get storage catan:engine state.p$(actor).dev[1]
$execute store result score #new ca_ctx run data get storage catan:engine state.p$(actor).fresh[1]
scoreboard players operation #old ca_ctx += #new ca_ctx
$execute store result storage catan:engine state.p$(actor).dev[1] int 1 run scoreboard players get #old ca_ctx
$data modify storage catan:engine state.p$(actor).fresh[1] set value 0
$execute store result score #old ca_ctx run data get storage catan:engine state.p$(actor).dev[2]
$execute store result score #new ca_ctx run data get storage catan:engine state.p$(actor).fresh[2]
scoreboard players operation #old ca_ctx += #new ca_ctx
$execute store result storage catan:engine state.p$(actor).dev[2] int 1 run scoreboard players get #old ca_ctx
$data modify storage catan:engine state.p$(actor).fresh[2] set value 0
$execute store result score #old ca_ctx run data get storage catan:engine state.p$(actor).dev[3]
$execute store result score #new ca_ctx run data get storage catan:engine state.p$(actor).fresh[3]
scoreboard players operation #old ca_ctx += #new ca_ctx
$execute store result storage catan:engine state.p$(actor).dev[3] int 1 run scoreboard players get #old ca_ctx
$data modify storage catan:engine state.p$(actor).fresh[3] set value 0
$execute store result score #old ca_ctx run data get storage catan:engine state.p$(actor).dev[4]
$execute store result score #new ca_ctx run data get storage catan:engine state.p$(actor).fresh[4]
scoreboard players operation #old ca_ctx += #new ca_ctx
$execute store result storage catan:engine state.p$(actor).dev[4] int 1 run scoreboard players get #old ca_ctx
$data modify storage catan:engine state.p$(actor).fresh[4] set value 0
