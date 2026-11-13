# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage magical_athlete:ui prior set from entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[$(index)]
execute unless data storage magical_athlete:ui prior{status:0,done:0} run return 0
execute store result score #earlier_owner ma_ctx run data get storage magical_athlete:ui prior.owner
execute if score #earlier_owner ma_ctx = @s ma_side run scoreboard players set #allowed ma_ctx 0
