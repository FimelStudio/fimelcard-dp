execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[7]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:4}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[12]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:12}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[13]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:13}
