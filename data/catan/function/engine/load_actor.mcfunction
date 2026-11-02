$scoreboard players operation #r0 ca_ctx = #res$(actor)_0 ca_ctx
$scoreboard players operation #r1 ca_ctx = #res$(actor)_1 ca_ctx
$scoreboard players operation #r2 ca_ctx = #res$(actor)_2 ca_ctx
$scoreboard players operation #r3 ca_ctx = #res$(actor)_3 ca_ctx
$scoreboard players operation #r4 ca_ctx = #res$(actor)_4 ca_ctx
$execute store result score #dev0 ca_ctx run data get storage catan:engine state.p$(actor).dev[0]
$execute store result score #dev1 ca_ctx run data get storage catan:engine state.p$(actor).dev[1]
$execute store result score #dev2 ca_ctx run data get storage catan:engine state.p$(actor).dev[2]
$execute store result score #dev3 ca_ctx run data get storage catan:engine state.p$(actor).dev[3]
$execute store result score #dev4 ca_ctx run data get storage catan:engine state.p$(actor).dev[4]
$execute store result score #fresh0 ca_ctx run data get storage catan:engine state.p$(actor).fresh[0]
$execute store result score #fresh1 ca_ctx run data get storage catan:engine state.p$(actor).fresh[1]
$execute store result score #fresh2 ca_ctx run data get storage catan:engine state.p$(actor).fresh[2]
$execute store result score #fresh3 ca_ctx run data get storage catan:engine state.p$(actor).fresh[3]
$execute store result score #fresh4 ca_ctx run data get storage catan:engine state.p$(actor).fresh[4]
$execute store result score #knights ca_ctx run data get storage catan:engine state.p$(actor).knights
$execute store result score #roads_left ca_ctx run data get storage catan:engine state.p$(actor).roads_left
$execute store result score #settlements_left ca_ctx run data get storage catan:engine state.p$(actor).settlements_left
$execute store result score #cities_left ca_ctx run data get storage catan:engine state.p$(actor).cities_left
$execute store result score #discard_due ca_ctx run data get storage catan:engine state.p$(actor).discard_due
