scoreboard players set @s xq_aistate 1
scoreboard players set @s xq_aiwait 4
scoreboard players operation @s xq_aiepoch = @s xq_epoch
data modify entity @s data.xiangqi.ai set value {queue:[],best:[{f:-1,t:-1,score:-10000000},{f:-1,t:-1,score:-10000000},{f:-1,t:-1,score:-10000000},{f:-1,t:-1,score:-10000000}],winner:{f:-1,t:-1,score:-10000000},seen:0,replies:0,replymax:0}
function xiangqi:ai/build_queue
