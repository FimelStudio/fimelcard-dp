execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[36]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:24}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[44]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:35}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[45]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:36}
