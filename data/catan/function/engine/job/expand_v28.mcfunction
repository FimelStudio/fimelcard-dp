execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[34]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:22}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[40]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:33}
execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[41]
execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {to:34}
