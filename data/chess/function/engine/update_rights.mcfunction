execute if score #piece ch_ctx matches 6 run function chess:engine/rights/remove1
execute if score #piece ch_ctx matches 6 run function chess:engine/rights/remove2
execute if score #piece ch_ctx matches -6 run function chess:engine/rights/remove4
execute if score #piece ch_ctx matches -6 run function chess:engine/rights/remove8
execute if score #from ch_ctx matches 0 if score #piece ch_ctx matches 4 run function chess:engine/rights/remove2
execute if score #to ch_ctx matches 0 if score #target ch_ctx matches 4 run function chess:engine/rights/remove2
execute if score #from ch_ctx matches 7 if score #piece ch_ctx matches 4 run function chess:engine/rights/remove1
execute if score #to ch_ctx matches 7 if score #target ch_ctx matches 4 run function chess:engine/rights/remove1
execute if score #from ch_ctx matches 56 if score #piece ch_ctx matches -4 run function chess:engine/rights/remove8
execute if score #to ch_ctx matches 56 if score #target ch_ctx matches -4 run function chess:engine/rights/remove8
execute if score #from ch_ctx matches 63 if score #piece ch_ctx matches -4 run function chess:engine/rights/remove4
execute if score #to ch_ctx matches 63 if score #target ch_ctx matches -4 run function chess:engine/rights/remove4
scoreboard players operation @s ch_castle = #castle ch_ctx
