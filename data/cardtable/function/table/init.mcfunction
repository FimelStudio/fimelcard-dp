# 控制器固定在牌桌中央；普通创建放置结构，现有桌模式只生成实体逻辑
scoreboard players add #next_id ct_ctx 1
scoreboard players operation @s ct_id = #next_id ct_ctx
execute unless score @s ct_capacity matches 8 run scoreboard players set @s ct_capacity 4
scoreboard players set @s ct_state 0
scoreboard players set @s ct_game 1
execute if score @s ct_capacity matches 8 run scoreboard players set @s ct_game 8
scoreboard players set @s ct_joined 0
scoreboard players set @s ct_votes 0

# 每个游戏只初始化自己的默认设置，通用牌桌不保存具体规则
function cardtable:game/init_selected
execute unless entity @s[tag=ct.no_structure] run function cardtable:table/build
execute if entity @s[tag=ct.no_structure] run function cardtable:table/spawn_seats

# 把本桌编号复制给刚生成的座椅和菜单实体
scoreboard players operation @e[tag=ct.new_part,distance=..5] ct_id = @s ct_id
scoreboard players set @e[tag=ct.new_seat1,distance=..3] ct_seat 1
scoreboard players set @e[tag=ct.new_seat2,distance=..3] ct_seat 2
scoreboard players set @e[tag=ct.new_seat3,distance=..3] ct_seat 3
scoreboard players set @e[tag=ct.new_seat4,distance=..3] ct_seat 4
scoreboard players set @e[tag=ct.new_seat1,distance=..3] ct_kind 11
scoreboard players set @e[tag=ct.new_seat2,distance=..3] ct_kind 12
scoreboard players set @e[tag=ct.new_seat3,distance=..3] ct_kind 13
scoreboard players set @e[tag=ct.new_seat4,distance=..3] ct_kind 14

tag @e[tag=ct.new_part,distance=..5] remove ct.new_part
tag @e[tag=ct.new_seat1,distance=..3] remove ct.new_seat1
tag @e[tag=ct.new_seat2,distance=..3] remove ct.new_seat2
tag @e[tag=ct.new_seat3,distance=..3] remove ct.new_seat3
tag @e[tag=ct.new_seat4,distance=..3] remove ct.new_seat4

function cardtable:menu/render
function cardtable:rules/render

# 新牌桌直接使用当前结构版本；后续菜单刷新不得改写迁移状态
data merge entity @s {data:{cardtable:{menu_version:13}}}
