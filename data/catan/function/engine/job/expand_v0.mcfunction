execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[0]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:3}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[1]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:4}
