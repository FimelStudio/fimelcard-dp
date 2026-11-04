data modify storage magical_athlete:ui pending set from entity @e[tag=ma.current,limit=1] data.magical_athlete.pending
execute unless data storage magical_athlete:ui pending{kind:"ready"} run return run tellraw @s {text:"选择快捷栏的接受、重掷或技能物品，按Q确认。",color:"yellow"}
execute store result score #code ma_ctx run data get storage magical_athlete:ui pending.options[0]
scoreboard players add #code ma_ctx 2100
scoreboard players operation @s ma_seen = @e[tag=ma.current,limit=1] ma_epoch
function magical_athlete:ui/dispatch
