scoreboard players operation @s ca_partner = #code ca_ctx
scoreboard players remove @s ca_partner 500
scoreboard players operation @s ca_seen = @e[tag=ca.current,limit=1] ca_epoch
function catan:ui/trade_begin
