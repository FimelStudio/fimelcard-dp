# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #encoded ma_ctx = @s ma_action
scoreboard players set @s ma_action 0
function magical_athlete:input/context
execute unless entity @s[tag=ma.actor] run scoreboard players reset @s ma_nonce
execute unless entity @s[tag=ma.actor] run return 0
execute unless score #encoded ma_ctx matches 20000..999992135 run return 0
scoreboard players operation #nonce ma_ctx = #encoded ma_ctx
scoreboard players operation #nonce ma_ctx /= #factor ma_ctx
execute unless score #nonce ma_ctx = @s ma_nonce run return 0
scoreboard players reset @s ma_nonce
execute unless score @s ma_ui_load = #ui_load ma_ctx run return run function magical_athlete:ui/stale
execute unless score @s ma_ui_table = @s ma_table run return run function magical_athlete:ui/stale
execute unless score @s ma_ui_seat = @s ct_seat run return run function magical_athlete:ui/stale
execute unless score @s ma_seen = @e[tag=ma.current,limit=1] ma_epoch run return run function magical_athlete:ui/stale
scoreboard players operation #code ma_ctx = #encoded ma_ctx
scoreboard players operation #code ma_ctx %= #factor ma_ctx
execute if score #code ma_ctx matches 0 run return run dialog clear @s
function magical_athlete:ui/dispatch
