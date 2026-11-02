execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[9]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:6}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[16]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:14}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[17]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:15}
