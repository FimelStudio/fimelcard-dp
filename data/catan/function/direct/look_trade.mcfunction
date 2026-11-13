scoreboard players operation @s ca_partner = #look_side ca_ctx
scoreboard players operation @s ca_seen = @e[tag=ca.current,limit=1] ca_epoch
execute unless score @s ca_side = @e[tag=ca.current,limit=1] ca_turn unless score #look_side ca_ctx = @e[tag=ca.current,limit=1] ca_turn run return run function catan:direct/wait
function catan:ui/trade_begin
