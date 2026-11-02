execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[53]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:37}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[61]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:46}
