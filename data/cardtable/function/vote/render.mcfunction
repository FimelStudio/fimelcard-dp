# 四个结束按钮位于每位玩家右手侧，并分别固定朝向桌外
# 规则介绍已拆分到 cardtable:rules 模块，不随投票界面重建
scoreboard players operation #ctx_id ct_ctx = @s ct_id
execute as @e[tag=ct.vote] if score @s ct_id = #ctx_id ct_ctx run kill @s

execute unless score @s ct_capacity matches 8 run function cardtable:vote/spawn4
execute if score @s ct_capacity matches 8 run function cardtable:vote/spawn8

execute as @e[nbt={data:{cardtable:{new_vote:1b}}},distance=..3] run tag @s add ct.new_vote
tag @e[tag=ct.new_vote,distance=..3] add ct.vote
tag @e[tag=ct.new_vote,distance=..3] add ct.part
scoreboard players operation @e[tag=ct.new_vote,distance=..3] ct_id = @s ct_id
execute as @e[type=minecraft:interaction,nbt={data:{cardtable:{end_vote:1b}}},distance=..3] run scoreboard players set @s ct_kind 30
execute as @e[tag=ct.new_vote,distance=..3] run data remove entity @s data.cardtable
tag @e[tag=ct.new_vote,distance=..3] remove ct.new_vote
