execute unless score #phase sp_ctx matches 1 run return run function splendor:engine/error {id:5}
scoreboard players set #total sp_ctx 0
scoreboard players set #same sp_ctx 0
scoreboard players set #available sp_ctx 0
execute unless score #take5 sp_ctx matches 0 run return run function splendor:engine/error {id:6}
execute unless score #take0 sp_ctx matches 0..2 run return run function splendor:engine/error {id:6}
execute if score #take0 sp_ctx > #bank0 sp_ctx run return run function splendor:engine/error {id:6}
scoreboard players operation #total sp_ctx += #take0 sp_ctx
execute if score #bank0 sp_ctx matches 1.. run scoreboard players add #available sp_ctx 1
execute if score #take0 sp_ctx matches 2 run scoreboard players add #same sp_ctx 1
execute if score #take0 sp_ctx matches 2 unless score #bank0 sp_ctx matches 4.. run return run function splendor:engine/error {id:6}
execute unless score #take1 sp_ctx matches 0..2 run return run function splendor:engine/error {id:6}
execute if score #take1 sp_ctx > #bank1 sp_ctx run return run function splendor:engine/error {id:6}
scoreboard players operation #total sp_ctx += #take1 sp_ctx
execute if score #bank1 sp_ctx matches 1.. run scoreboard players add #available sp_ctx 1
execute if score #take1 sp_ctx matches 2 run scoreboard players add #same sp_ctx 1
execute if score #take1 sp_ctx matches 2 unless score #bank1 sp_ctx matches 4.. run return run function splendor:engine/error {id:6}
execute unless score #take2 sp_ctx matches 0..2 run return run function splendor:engine/error {id:6}
execute if score #take2 sp_ctx > #bank2 sp_ctx run return run function splendor:engine/error {id:6}
scoreboard players operation #total sp_ctx += #take2 sp_ctx
execute if score #bank2 sp_ctx matches 1.. run scoreboard players add #available sp_ctx 1
execute if score #take2 sp_ctx matches 2 run scoreboard players add #same sp_ctx 1
execute if score #take2 sp_ctx matches 2 unless score #bank2 sp_ctx matches 4.. run return run function splendor:engine/error {id:6}
execute unless score #take3 sp_ctx matches 0..2 run return run function splendor:engine/error {id:6}
execute if score #take3 sp_ctx > #bank3 sp_ctx run return run function splendor:engine/error {id:6}
scoreboard players operation #total sp_ctx += #take3 sp_ctx
execute if score #bank3 sp_ctx matches 1.. run scoreboard players add #available sp_ctx 1
execute if score #take3 sp_ctx matches 2 run scoreboard players add #same sp_ctx 1
execute if score #take3 sp_ctx matches 2 unless score #bank3 sp_ctx matches 4.. run return run function splendor:engine/error {id:6}
execute unless score #take4 sp_ctx matches 0..2 run return run function splendor:engine/error {id:6}
execute if score #take4 sp_ctx > #bank4 sp_ctx run return run function splendor:engine/error {id:6}
scoreboard players operation #total sp_ctx += #take4 sp_ctx
execute if score #bank4 sp_ctx matches 1.. run scoreboard players add #available sp_ctx 1
execute if score #take4 sp_ctx matches 2 run scoreboard players add #same sp_ctx 1
execute if score #take4 sp_ctx matches 2 unless score #bank4 sp_ctx matches 4.. run return run function splendor:engine/error {id:6}
execute unless score #total sp_ctx matches 1..3 run return run function splendor:engine/error {id:6}
execute if score #same sp_ctx matches 1.. unless score #total sp_ctx matches 2 run return run function splendor:engine/error {id:6}
execute if score #available sp_ctx matches 4.. run scoreboard players set #available sp_ctx 3
execute if score #same sp_ctx matches 0 unless score #total sp_ctx = #available sp_ctx run return run function splendor:engine/error {id:6}
scoreboard players operation #token0 sp_ctx += #take0 sp_ctx
scoreboard players operation #bank0 sp_ctx -= #take0 sp_ctx
scoreboard players operation #token1 sp_ctx += #take1 sp_ctx
scoreboard players operation #bank1 sp_ctx -= #take1 sp_ctx
scoreboard players operation #token2 sp_ctx += #take2 sp_ctx
scoreboard players operation #bank2 sp_ctx -= #take2 sp_ctx
scoreboard players operation #token3 sp_ctx += #take3 sp_ctx
scoreboard players operation #bank3 sp_ctx -= #take3 sp_ctx
scoreboard players operation #token4 sp_ctx += #take4 sp_ctx
scoreboard players operation #bank4 sp_ctx -= #take4 sp_ctx
scoreboard players operation #token5 sp_ctx += #take5 sp_ctx
scoreboard players operation #bank5 sp_ctx -= #take5 sp_ctx
data modify storage splendor:engine state.last.take set from storage splendor:engine request.take
function splendor:engine/save_actor with storage splendor:engine request
function splendor:engine/save_bank
function splendor:engine/after_action
scoreboard players set #ok sp_ctx 1
