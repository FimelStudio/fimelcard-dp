execute unless score #phase sp_ctx matches 1 run return run function splendor:engine/error {id:5}
execute if score #reserved sp_ctx matches 3.. run return run function splendor:engine/error {id:11}
scoreboard players set #valid sp_ctx 0
function splendor:engine/resolve
execute unless score #valid sp_ctx matches 1 run return 0
execute store result storage splendor:engine request.card int 1 run scoreboard players get #card sp_ctx
function splendor:engine/append_reserve with storage splendor:engine request
function splendor:engine/remove_card
execute if score #bank5 sp_ctx matches 1.. run scoreboard players add #token5 sp_ctx 1
execute if score #bank5 sp_ctx matches 1.. run data modify storage splendor:engine state.last.take[5] set value 1
execute if score #bank5 sp_ctx matches 1.. run scoreboard players remove #bank5 sp_ctx 1
function splendor:engine/save_actor with storage splendor:engine request
function splendor:engine/save_bank
function splendor:engine/after_action
scoreboard players set #ok sp_ctx 1
