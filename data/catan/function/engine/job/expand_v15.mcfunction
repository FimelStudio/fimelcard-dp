execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[17]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:10}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[22]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:20}
