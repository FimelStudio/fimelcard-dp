# 创建的是通用牌桌会话；具体游戏及其设置由注册的游戏模块自行初始化
execute unless entity @s[type=minecraft:player] run return fail

# 防止两张牌桌过近而导致座位和菜单交互范围重叠
execute if entity @e[type=minecraft:marker,tag=ct.controller,distance=..9] run tellraw @s [{text:'[牌桌] ',color:'dark_aqua'},{text:'附近已有牌桌，请至少间隔9格。',color:'red'}]
execute if entity @e[type=minecraft:marker,tag=ct.controller,distance=..9] run return fail

# 用临时标签保留创建者，并把5×5结构的中心对齐到方块中央
tag @e[type=minecraft:marker,tag=ct.new_controller] remove ct.new_controller
tag @s add ct.creator
execute align xyz positioned ~0.5 ~ ~0.5 run summon minecraft:marker ~ ~ ~ {data:{cardtable:{new_controller:1b}}}
tag @e[type=minecraft:marker,nbt={data:{cardtable:{new_controller:1b}}},distance=..1,sort=nearest,limit=1] add ct.controller
tag @e[type=minecraft:marker,nbt={data:{cardtable:{new_controller:1b}}},distance=..1,sort=nearest,limit=1] add ct.new_controller
# create_safe调用者会带此临时标签；把“跳过结构”选项传给新控制器
execute if entity @s[tag=ct.create_no_blocks] run tag @e[type=minecraft:marker,tag=ct.new_controller,distance=..1,sort=nearest,limit=1] add ct.no_structure
execute as @e[type=minecraft:marker,nbt={data:{cardtable:{new_controller:1b}}},distance=..1,sort=nearest,limit=1] run data remove entity @s data.cardtable
execute as @e[type=minecraft:marker,tag=ct.new_controller,distance=..1,sort=nearest,limit=1] at @s run function cardtable:admin/create/init_controller
tag @s remove ct.creator
