execute unless score #phase sp_ctx matches 1 run return run function splendor:engine/error {id:5}
scoreboard players set #valid sp_ctx 0
function splendor:engine/resolve
execute unless score #valid sp_ctx matches 1 run return 0
scoreboard players set #gold_needed sp_ctx 0
scoreboard players operation #cost0 sp_ctx -= #bonus0 sp_ctx
execute if score #cost0 sp_ctx matches ..-1 run scoreboard players set #cost0 sp_ctx 0
execute if score #pay0 sp_ctx > #cost0 sp_ctx run return run function splendor:engine/error {id:12}
execute if score #pay0 sp_ctx > #token0 sp_ctx run return run function splendor:engine/error {id:12}
scoreboard players operation #cost0 sp_ctx -= #pay0 sp_ctx
scoreboard players operation #gold_needed sp_ctx += #cost0 sp_ctx
scoreboard players operation #cost1 sp_ctx -= #bonus1 sp_ctx
execute if score #cost1 sp_ctx matches ..-1 run scoreboard players set #cost1 sp_ctx 0
execute if score #pay1 sp_ctx > #cost1 sp_ctx run return run function splendor:engine/error {id:12}
execute if score #pay1 sp_ctx > #token1 sp_ctx run return run function splendor:engine/error {id:12}
scoreboard players operation #cost1 sp_ctx -= #pay1 sp_ctx
scoreboard players operation #gold_needed sp_ctx += #cost1 sp_ctx
scoreboard players operation #cost2 sp_ctx -= #bonus2 sp_ctx
execute if score #cost2 sp_ctx matches ..-1 run scoreboard players set #cost2 sp_ctx 0
execute if score #pay2 sp_ctx > #cost2 sp_ctx run return run function splendor:engine/error {id:12}
execute if score #pay2 sp_ctx > #token2 sp_ctx run return run function splendor:engine/error {id:12}
scoreboard players operation #cost2 sp_ctx -= #pay2 sp_ctx
scoreboard players operation #gold_needed sp_ctx += #cost2 sp_ctx
scoreboard players operation #cost3 sp_ctx -= #bonus3 sp_ctx
execute if score #cost3 sp_ctx matches ..-1 run scoreboard players set #cost3 sp_ctx 0
execute if score #pay3 sp_ctx > #cost3 sp_ctx run return run function splendor:engine/error {id:12}
execute if score #pay3 sp_ctx > #token3 sp_ctx run return run function splendor:engine/error {id:12}
scoreboard players operation #cost3 sp_ctx -= #pay3 sp_ctx
scoreboard players operation #gold_needed sp_ctx += #cost3 sp_ctx
scoreboard players operation #cost4 sp_ctx -= #bonus4 sp_ctx
execute if score #cost4 sp_ctx matches ..-1 run scoreboard players set #cost4 sp_ctx 0
execute if score #pay4 sp_ctx > #cost4 sp_ctx run return run function splendor:engine/error {id:12}
execute if score #pay4 sp_ctx > #token4 sp_ctx run return run function splendor:engine/error {id:12}
scoreboard players operation #cost4 sp_ctx -= #pay4 sp_ctx
scoreboard players operation #gold_needed sp_ctx += #cost4 sp_ctx
execute unless score #gold_needed sp_ctx = #pay5 sp_ctx run return run function splendor:engine/error {id:12}
execute if score #pay5 sp_ctx > #token5 sp_ctx run return run function splendor:engine/error {id:12}
scoreboard players operation #token0 sp_ctx -= #pay0 sp_ctx
scoreboard players operation #bank0 sp_ctx += #pay0 sp_ctx
scoreboard players operation #token1 sp_ctx -= #pay1 sp_ctx
scoreboard players operation #bank1 sp_ctx += #pay1 sp_ctx
scoreboard players operation #token2 sp_ctx -= #pay2 sp_ctx
scoreboard players operation #bank2 sp_ctx += #pay2 sp_ctx
scoreboard players operation #token3 sp_ctx -= #pay3 sp_ctx
scoreboard players operation #bank3 sp_ctx += #pay3 sp_ctx
scoreboard players operation #token4 sp_ctx -= #pay4 sp_ctx
scoreboard players operation #bank4 sp_ctx += #pay4 sp_ctx
scoreboard players operation #token5 sp_ctx -= #pay5 sp_ctx
scoreboard players operation #bank5 sp_ctx += #pay5 sp_ctx
execute if score #bonus sp_ctx matches 0 run scoreboard players add #bonus0 sp_ctx 1
execute if score #bonus sp_ctx matches 1 run scoreboard players add #bonus1 sp_ctx 1
execute if score #bonus sp_ctx matches 2 run scoreboard players add #bonus2 sp_ctx 1
execute if score #bonus sp_ctx matches 3 run scoreboard players add #bonus3 sp_ctx 1
execute if score #bonus sp_ctx matches 4 run scoreboard players add #bonus4 sp_ctx 1
scoreboard players operation #vp sp_ctx += #points sp_ctx
execute store result storage splendor:engine request.card int 1 run scoreboard players get #card sp_ctx
function splendor:engine/append_bought with storage splendor:engine request
function splendor:engine/remove_card
data modify storage splendor:engine state.last.pay set from storage splendor:engine request.pay
function splendor:engine/save_actor with storage splendor:engine request
function splendor:engine/save_bank
function splendor:engine/after_action
scoreboard players set #ok sp_ctx 1
