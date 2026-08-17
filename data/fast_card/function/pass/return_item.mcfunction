# 保留完整物品组件，取消飞行和拾取冷却后传回原玩家脚下
data modify entity @s Owner set from entity @a[tag=fc.return_owner,limit=1] UUID
data merge entity @s {PickupDelay:0s,Motion:[0.0d,0.0d,0.0d]}
tp @s @a[tag=fc.return_owner,limit=1]
scoreboard players set #return_done fc_ctx 1
