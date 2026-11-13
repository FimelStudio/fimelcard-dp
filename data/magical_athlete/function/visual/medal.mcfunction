scoreboard players set #silver ma_ctx -1
execute store result score #silver ma_ctx run data get entity @s data.magical_athlete.finishers[1]
$scoreboard players set #crossed ma_ctx $(pawn)
execute if score #silver ma_ctx = #crossed ma_ctx run data modify storage magical_athlete:visual prop set value "medal_silver"
