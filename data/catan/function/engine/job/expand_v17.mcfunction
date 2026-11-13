execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[19]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:12}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[25]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:22}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[26]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:23}
