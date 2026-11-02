execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[4]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:5}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[5]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:6}
