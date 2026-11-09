# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function magical_athlete:system/context
execute as @a[tag=ma.audience] run scoreboard players set @s ma_depoch -1
execute as @a[tag=ma.audience] run function magical_athlete:direct/sync
function magical_athlete:game/hud
