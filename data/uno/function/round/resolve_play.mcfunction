scoreboard players set @s un_pending 0
# 先应用方向，再寻找下家；二人反转等同跳过。
execute if score @s un_effect matches 2 run scoreboard players operation @s un_dir *= #minus un_ctx
function uno:round/step
execute if score @s un_effect matches 1 run function uno:round/step
execute if score @s un_effect matches 2 if score @s un_size matches 2 run function uno:round/step
execute if score @s un_effect matches 3 run function uno:round/penalty_two
execute if score @s un_effect matches 4 run return run function uno:round/offer_four
execute if score @s un_winner matches 1..8 run return run function uno:round/win
function uno:round/turn_begin
