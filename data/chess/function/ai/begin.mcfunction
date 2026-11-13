scoreboard players set @s ch_aistate 1
scoreboard players set @s ch_aiwait 4
scoreboard players operation @s ch_aiepoch = @s ch_epoch
data modify entity @s data.chess.ai set value {queue:[],best:[{f:-1,t:-1,score:-10000000},{f:-1,t:-1,score:-10000000},{f:-1,t:-1,score:-10000000},{f:-1,t:-1,score:-10000000}],winner:{f:-1,t:-1,score:-10000000},seen:0,replies:0,replymax:0}
function chess:ai/build_queue
