execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[33]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:21}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[39]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:33}
