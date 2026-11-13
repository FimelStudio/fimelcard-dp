execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[35]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:23}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[42]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:34}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[43]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:35}
