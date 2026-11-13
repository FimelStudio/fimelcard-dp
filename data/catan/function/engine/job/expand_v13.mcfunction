execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[13]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:8}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[14]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:9}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[20]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:18}
