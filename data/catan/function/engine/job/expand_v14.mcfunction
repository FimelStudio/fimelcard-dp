execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[15]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:9}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[16]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:10}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[21]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:19}
