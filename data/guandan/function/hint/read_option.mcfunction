$data modify storage guandan:hint option set from entity @s data.guandan.options[$(index)]
execute unless data storage guandan:hint option{beat:1} run return 0
execute store result score #kind gd_ctx run data get storage guandan:hint option.kind
execute store result score #size gd_ctx run data get storage guandan:hint option.size
execute store result score #high gd_ctx run data get storage guandan:hint option.high
execute store result score #power gd_ctx run data get storage guandan:hint option.power
function guandan:hint/key
execute if score #hint_key gd_ctx = @s gd_hint run scoreboard players operation #hint_choice gd_ctx = #hint_index gd_ctx
