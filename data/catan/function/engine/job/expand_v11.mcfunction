execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[10]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:7}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[18]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:16}
