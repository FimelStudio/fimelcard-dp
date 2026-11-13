execute if score #vp sp_ctx matches 15.. run scoreboard players set #final_round sp_ctx 1
execute store result storage splendor:engine state.final_round int 1 run scoreboard players get #final_round sp_ctx
data modify storage splendor:engine state.phase set value 1
data modify storage splendor:engine state.eligible set value []
execute if score #final_round sp_ctx matches 1 if score #turn sp_ctx = #n sp_ctx run return run function splendor:engine/finish
scoreboard players add #turn sp_ctx 1
execute if score #turn sp_ctx > #n sp_ctx run scoreboard players add #round sp_ctx 1
execute if score #turn sp_ctx > #n sp_ctx run scoreboard players set #turn sp_ctx 1
execute store result storage splendor:engine state.turn int 1 run scoreboard players get #turn sp_ctx
execute store result storage splendor:engine state.round int 1 run scoreboard players get #round sp_ctx
