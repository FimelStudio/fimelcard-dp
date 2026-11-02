scoreboard players operation #encoded ca_ctx = @s ca_action
scoreboard players set @s ca_action 0
function catan:input/context
execute unless entity @s[tag=ca.actor] run return 0
execute unless score #encoded ca_ctx matches 20000..999991141 run return 0
scoreboard players operation #nonce ca_ctx = #encoded ca_ctx
scoreboard players operation #nonce ca_ctx /= #factor ca_ctx
execute unless score #nonce ca_ctx = @s ca_nonce run return 0
scoreboard players reset @s ca_nonce
execute unless score @s ca_ui_load = #ui_load ca_ctx run return run function catan:ui/stale
execute unless score @s ca_ui_table = @s ca_table run return run function catan:ui/stale
execute unless score @s ca_seen = @e[tag=ca.current,limit=1] ca_epoch run return run function catan:ui/stale
scoreboard players operation #code ca_ctx = #encoded ca_ctx
scoreboard players operation #code ca_ctx %= #factor ca_ctx
function catan:ui/dispatch
