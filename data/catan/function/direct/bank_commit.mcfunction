function catan:direct/bank_validate
execute unless score #direct_ready ca_ctx matches 1 run return 0
function catan:ui/send_bank
