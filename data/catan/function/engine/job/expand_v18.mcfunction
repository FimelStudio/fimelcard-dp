execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[20]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:13}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[27]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:23}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[28]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:24}
