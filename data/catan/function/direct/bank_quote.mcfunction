function catan:direct/bank_validate
execute if score #direct_ready ca_ctx matches 1 run function catan:direct/bank_note with storage catan:direct
