execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[24]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:16}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[25]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:17}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[34]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:28}
