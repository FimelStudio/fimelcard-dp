# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #encoded sp_ctx = @s sp_action
scoreboard players set @s sp_action 0
function splendor:input/context
execute unless entity @s[tag=sp.actor] run return 0
execute unless score #encoded sp_ctx matches 20000..999990999 run return 0
scoreboard players operation #nonce sp_ctx = #encoded sp_ctx
scoreboard players operation #nonce sp_ctx /= #factor sp_ctx
execute unless score #nonce sp_ctx = @s sp_nonce run return 0
scoreboard players reset @s sp_nonce
execute unless score @s sp_ui_load = #ui_load sp_ctx run return run function splendor:ui/stale
execute unless score @s sp_ui_table = @s sp_table run return run function splendor:ui/stale
execute unless score @s sp_seen = @e[tag=sp.current,limit=1] sp_epoch run return run function splendor:ui/stale
scoreboard players operation #code sp_ctx = #encoded sp_ctx
scoreboard players operation #code sp_ctx %= #factor sp_ctx
execute if score #code sp_ctx matches 0 run return run dialog clear @s
function splendor:ui/dispatch
