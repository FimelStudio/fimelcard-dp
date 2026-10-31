scoreboard players set @s gm_aistate 1
scoreboard players set @s gm_aiwait 4
scoreboard players operation @s gm_aiepoch = @s gm_epoch
data modify entity @s data.gomoku.ai set value {stage:1,index:0,root:0,root_sq:-1,chosen:-1,best:-2000000000,reply:0,top:[{sq:-1,score:-1000000000},{sq:-1,score:-1000000000},{sq:-1,score:-1000000000}]}
execute if score @s gm_moves matches 0 run function gomoku:ai/opening
