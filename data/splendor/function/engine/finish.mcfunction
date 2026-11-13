data modify storage splendor:engine state.phase set value 4
data modify storage splendor:engine state.winners set value []
scoreboard players set #best_vp sp_ctx -1
scoreboard players set #best_cards sp_ctx 999
execute if score #n sp_ctx matches 1..4 run function splendor:engine/winner {actor:1}
execute if score #n sp_ctx matches 2..4 run function splendor:engine/winner {actor:2}
execute if score #n sp_ctx matches 3..4 run function splendor:engine/winner {actor:3}
execute if score #n sp_ctx matches 4..4 run function splendor:engine/winner {actor:4}
