execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[38]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:26}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[48]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:37}
