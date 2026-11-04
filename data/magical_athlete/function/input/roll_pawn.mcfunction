$execute store result score #roll_owner ma_ctx run data get entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[$(index)].owner
$execute if score #roll_owner ma_ctx = @s ma_side if data entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[$(index)]{status:0} run scoreboard players set #roll_pawn ma_ctx $(index)
