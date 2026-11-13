scoreboard players set #selected ca_ctx 0
scoreboard players operation #selected ca_ctx += @s ca_g0
scoreboard players operation #selected ca_ctx += @s ca_g1
scoreboard players operation #selected ca_ctx += @s ca_g2
scoreboard players operation #selected ca_ctx += @s ca_g3
scoreboard players operation #selected ca_ctx += @s ca_g4
execute store result score #due ca_ctx run data get storage catan:ui hand.discard_due
execute store result storage catan:direct selected int 1 run scoreboard players get #selected ca_ctx
execute store result storage catan:direct due int 1 run scoreboard players get #due ca_ctx
function catan:direct/discard_note with storage catan:direct
execute if score #selected ca_ctx = #due ca_ctx run function catan:direct/discard_commit
