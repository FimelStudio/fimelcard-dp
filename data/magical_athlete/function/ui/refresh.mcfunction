# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function magical_athlete:system/context
execute as @a[tag=ma.audience] run function magical_athlete:input/give
execute if score @s ma_anim matches 1.. run return 0
execute if data entity @s data.magical_athlete.queue[0] unless data entity @s data.magical_athlete.pending.options[0] run return 0
execute if score @s ma_state matches 2 as @a[tag=ma.audience] run function magical_athlete:ui/open
execute unless score @s ma_state matches 2 as @a[tag=ma.audience] if score @s ma_side = @e[tag=ma.current,limit=1] ma_pending run function magical_athlete:ui/open
execute unless score @s ma_state matches 2 if score @s ma_pending matches 0 as @a[tag=ma.audience] if score @s ma_side = @e[tag=ma.current,limit=1] ma_turn run function magical_athlete:ui/open
