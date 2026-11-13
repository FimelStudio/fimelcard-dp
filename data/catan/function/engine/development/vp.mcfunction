$execute store result score #vp ca_ctx run data get storage catan:engine state.p$(actor).vp
execute unless score #vp ca_ctx matches 10.. run return run function catan:engine/error {id:10}
scoreboard players set #ok ca_ctx 1
