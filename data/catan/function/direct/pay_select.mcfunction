scoreboard players operation @s ca_pay = #resource ca_ctx
scoreboard players set @s ca_receive -1
function catan:direct/bank_read
function catan:direct/bank_payment with storage catan:direct
execute unless score #direct_ready ca_ctx matches 1 run return 0
scoreboard players set @s ca_step 1
function catan:direct/pay_note with storage catan:direct
