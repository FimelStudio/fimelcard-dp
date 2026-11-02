execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[2]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:4}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[3]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:5}
