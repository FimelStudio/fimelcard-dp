execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[30]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:19}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[31]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:20}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[37]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:31}
