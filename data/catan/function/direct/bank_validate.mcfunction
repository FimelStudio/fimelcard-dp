function catan:direct/main_guard
execute unless score #direct_ready ca_ctx matches 1 run return 0
function catan:direct/bank_read
function catan:direct/bank_payment with storage catan:direct
execute unless score #direct_ready ca_ctx matches 1 run return 0
execute if score @s ca_pay = @s ca_receive run return run function catan:direct/bank_same
function catan:direct/bank_stock with storage catan:direct
