execute unless score @s ca_edit matches 1 run return run function catan:direct/cancel
scoreboard players set #removed ca_ctx 0
execute if score #removed ca_ctx matches 0 if score @s ca_g4 matches 1.. run function catan:direct/undo_one {id:4}
execute if score #removed ca_ctx matches 0 if score @s ca_g3 matches 1.. run function catan:direct/undo_one {id:3}
execute if score #removed ca_ctx matches 0 if score @s ca_g2 matches 1.. run function catan:direct/undo_one {id:2}
execute if score #removed ca_ctx matches 0 if score @s ca_g1 matches 1.. run function catan:direct/undo_one {id:1}
execute if score #removed ca_ctx matches 0 if score @s ca_g0 matches 1.. run function catan:direct/undo_one {id:0}
execute store result storage catan:ui side int 1 run scoreboard players get @s ca_side
function catan:direct/private
function catan:direct/discard_progress
