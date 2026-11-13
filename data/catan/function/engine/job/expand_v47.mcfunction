execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[62]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:43}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[66]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:51}
