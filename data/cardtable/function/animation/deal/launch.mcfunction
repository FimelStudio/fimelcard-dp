# 宏参数seat为目标座位；调用前必须在牌桌中心生成并配置一件带ct.new_dealt_card标签的物品
# 示例：function cardtable:animation/deal/launch {seat:2}
$scoreboard players set #deal_seat ct_ctx $(seat)
scoreboard players operation #ctx_id ct_ctx = @s ct_id
execute unless entity @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] run return fail

# 根据通用牌桌编号和座位寻找接收者
tag @a[tag=ct.deal_receiver] remove ct.deal_receiver
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id ct_ctx if score @s ct_seat = #deal_seat ct_ctx run tag @s add ct.deal_receiver
execute unless entity @a[tag=ct.deal_receiver,limit=1] run kill @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1]
execute unless entity @a[tag=ct.deal_receiver,limit=1] run return fail

# 限制拾取者并写入公共实例、座位和飞行计时
data modify entity @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] Owner set from entity @a[tag=ct.deal_receiver,limit=1] UUID
execute as @e[type=minecraft:item,tag=ct.new_dealt_card,tag=ct.visual_only,distance=..2,sort=nearest,limit=1] run data merge entity @s {PickupDelay:32767s}
scoreboard players operation @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] ct_id = @s ct_id
scoreboard players operation @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] ct_seat = #deal_seat ct_ctx
scoreboard players set @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] ct_anim 0

# 按接收者当前坐标计算约四刻能够到达的水平动量，Y轴由调用方生成物品时设置
execute store result score #deal_target_x ct_ctx run data get entity @a[tag=ct.deal_receiver,limit=1] Pos[0] 1000
execute store result score #deal_origin_x ct_ctx run data get entity @s Pos[0] 1000
scoreboard players operation #deal_target_x ct_ctx -= #deal_origin_x ct_ctx
execute store result storage cardtable:deal motion_x double 0.00026 run scoreboard players get #deal_target_x ct_ctx
data modify entity @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] Motion[0] set from storage cardtable:deal motion_x

execute store result score #deal_target_z ct_ctx run data get entity @a[tag=ct.deal_receiver,limit=1] Pos[2] 1000
execute store result score #deal_origin_z ct_ctx run data get entity @s Pos[2] 1000
scoreboard players operation #deal_target_z ct_ctx -= #deal_origin_z ct_ctx
execute store result storage cardtable:deal motion_z double 0.00026 run scoreboard players get #deal_target_z ct_ctx
data modify entity @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] Motion[2] set from storage cardtable:deal motion_z

tag @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] add ct.dealt_card
tag @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,sort=nearest,limit=1] remove ct.new_dealt_card
tag @a[tag=ct.deal_receiver] remove ct.deal_receiver
