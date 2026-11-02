execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[65]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:46}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[71]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:53}
