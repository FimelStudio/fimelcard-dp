execute if score @s ca_finish matches 1.. run return 0
execute unless score @s ca_winner matches 1..4 run return 0
scoreboard players set @s ca_finish 100
scoreboard players set @s ca_anim 0
function catan:input/clear_surface
function catan:sound/result
data modify entity @s data.catan.last.kind set value "win"
execute store result entity @s data.catan.last.owner int 1 run scoreboard players get @s ca_winner
function catan:visual/animate
function catan:game/winner_announce with entity @s data.catan
function catan:game/firework
