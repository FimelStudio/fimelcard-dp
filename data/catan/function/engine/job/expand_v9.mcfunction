execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[8]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:5}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[14]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:13}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[15]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:14}
