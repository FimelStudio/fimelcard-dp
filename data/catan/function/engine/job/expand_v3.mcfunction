execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[0]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:0}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[6]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:7}
