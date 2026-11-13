scoreboard players set @s ca_confirm -999
scoreboard players operation @s ca_seen = @e[tag=ca.current,limit=1] ca_epoch
execute if score #code ca_ctx matches 352 unless score @s ca_pay matches 0..4 run return run function catan:direct/choose_first
execute if score #code ca_ctx matches 352 unless score @s ca_receive matches 0..4 run return run function catan:direct/choose_first
execute if score #code ca_ctx matches 353..354 unless score @s ca_a matches 0..4 run return run function catan:direct/choose_first
execute if score #code ca_ctx matches 354 unless score @s ca_b matches 0..4 run return run function catan:direct/choose_first
execute if score #code ca_ctx matches 352 run return run function catan:direct/bank_commit
execute if score #code ca_ctx matches 353 run return run function catan:ui/send_monopoly
execute if score #code ca_ctx matches 354 run return run function catan:ui/send_plenty
execute if score #code ca_ctx matches 401..404 run return run function catan:direct/steal
execute if score #code ca_ctx matches 600..603 run return run function catan:direct/dev_submit
execute store result storage catan:direct code int 1 run scoreboard players get #code ca_ctx
function catan:ui/simple with storage catan:direct
