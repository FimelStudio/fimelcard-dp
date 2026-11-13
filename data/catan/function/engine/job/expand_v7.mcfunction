execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[6]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:3}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[10]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:11}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[11]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:12}
