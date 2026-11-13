execute unless score @s gd_auto matches 0..100 run function guandan:autopass/check
execute unless score @s gd_auto matches 1..100 run return 0
scoreboard players remove @s gd_auto 1
execute unless score @s gd_auto matches 0 run return 0
scoreboard players operation #actor gd_ctx = @s gd_turn
execute as @a[tag=gd.audience] if score @s gd_seat = #actor gd_ctx run dialog clear @s
function guandan:game/pass
return 1
