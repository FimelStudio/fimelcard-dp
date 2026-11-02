data modify storage catan:engine tmp set from storage catan:engine state.job
function catan:engine/job/save_length with storage catan:engine tmp
execute store result score #jp ca_ctx run data get storage catan:engine state.job.player
scoreboard players add #jp ca_ctx 1
execute store result storage catan:engine state.job.player int 1 run scoreboard players get #jp ca_ctx
execute if score #jp ca_ctx <= #n ca_ctx run return run function catan:engine/job/prepare
function catan:engine/job/finish
