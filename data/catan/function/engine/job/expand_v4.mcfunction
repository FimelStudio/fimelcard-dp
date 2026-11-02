execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[1]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:0}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[2]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:1}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[7]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:8}
