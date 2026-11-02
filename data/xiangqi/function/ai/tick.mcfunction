# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless score @s ct_state matches 1 run return run function xiangqi:ai/reset
execute unless score @s xq_state matches 1 run return 0
execute unless score @s xq_bot matches -1 unless score @s xq_bot matches 1 run return run function xiangqi:ai/reset
execute unless score @s xq_turn = @s xq_bot run return run function xiangqi:ai/reset
execute if score @s xq_aistate matches 1.. unless score @s xq_aiepoch = @s xq_epoch run return run function xiangqi:ai/reset
execute unless score @s xq_level matches 1..3 run scoreboard players set @s xq_level 2
execute if score @s xq_aiwait matches 1.. run return run scoreboard players remove @s xq_aiwait 1
function xiangqi:system/context
function xiangqi:engine/cache
execute unless score #cache_ok xq_ctx matches 1 run return run function xiangqi:ai/no_move
execute if score @s xq_aistate matches 0 run return run function xiangqi:ai/begin
execute if score @s xq_aistate matches 1 run return run function xiangqi:ai/root_tick
execute if score @s xq_aistate matches 2 run return run function xiangqi:ai/reply_tick
return run function xiangqi:ai/reset
