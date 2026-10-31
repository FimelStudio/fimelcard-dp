execute unless score @s ct_state matches 1 run return run function chess:ai/reset
execute unless score @s ch_state matches 1 run return 0
execute unless score @s ch_bot matches -1 unless score @s ch_bot matches 1 run return run function chess:ai/reset
execute unless score @s ch_turn = @s ch_bot run return run function chess:ai/reset
execute if score @s ch_aistate matches 1.. unless score @s ch_aiepoch = @s ch_epoch run return run function chess:ai/reset
execute unless score @s ch_level matches 1..3 run scoreboard players set @s ch_level 2
execute if score @s ch_aiwait matches 1.. run return run scoreboard players remove @s ch_aiwait 1
function chess:system/context
function chess:engine/cache
execute unless score #cache_ok ch_ctx matches 1 run return run function chess:ai/reset
execute if score @s ch_aistate matches 0 run return run function chess:ai/begin
execute if score @s ch_aistate matches 1 run return run function chess:ai/root_tick
execute if score @s ch_aistate matches 2 run return run function chess:ai/reply_tick
return run function chess:ai/reset
