execute store result score @s ma_state run data get entity @s data.magical_athlete.phase
execute store result score @s ma_epoch run data get entity @s data.magical_athlete.epoch
execute store result score @s ma_turn run data get entity @s data.magical_athlete.turn
scoreboard players set @s ma_pending 0
execute store result score @s ma_pending run data get entity @s data.magical_athlete.pending.owner
