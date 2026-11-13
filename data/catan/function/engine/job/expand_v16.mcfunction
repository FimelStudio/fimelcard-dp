execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[18]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:11}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[23]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:21}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[24]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:22}
