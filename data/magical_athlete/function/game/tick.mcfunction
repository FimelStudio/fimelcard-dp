# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @s ct_paused matches 1 run return 0
function magical_athlete:system/context
function magical_athlete:sound/tick
scoreboard players add @s ma_pulse 1
execute if score @s ma_pulse matches 20.. run function magical_athlete:game/hud
execute if score @s ma_finish matches 1.. run return run function magical_athlete:game/finish_tick
execute if score @s ma_anim matches 1.. run function magical_athlete:visual/tick
execute if score @s ma_anim matches 0 run function magical_athlete:game/pump
execute if score @s ma_pulse matches 0 as @a[tag=ma.audience] run function magical_athlete:input/give
# direct-v2
execute as @e[tag=ma.hit] if score @s ct_id = #table ma_ctx if data entity @s interaction run function magical_athlete:direct/click
execute as @e[tag=ma.hit] if score @s ct_id = #table ma_ctx if data entity @s attack run function magical_athlete:direct/left
function magical_athlete:direct/countdown
# feedback-v1
execute if score @s ma_pulse matches 0 run function magical_athlete:feedback/guide
