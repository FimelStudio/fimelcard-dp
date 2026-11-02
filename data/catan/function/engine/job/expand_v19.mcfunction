execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[21]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:14}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[29]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:24}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[30]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:25}
