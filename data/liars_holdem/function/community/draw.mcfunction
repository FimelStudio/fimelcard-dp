# 当前执行者和执行位置始终是牌桌控制器；所有公共牌先重叠在桌心
function liars_holdem:deck/select_random
execute unless entity @e[tag=lh.drawn,limit=1] run return fail
scoreboard players operation @s lh_card = @e[tag=lh.drawn,limit=1] lh_card
function liars_holdem:card/load_definition

# on_shelf上下文会让牌背默认朝上；翻牌时再绕Z轴180度显示真实牌面
summon minecraft:item_display ~ ~1.1 ~ {data:{liars_holdem:{new_community:1b}},item:{id:"minecraft:paper",count:1},item_display:"on_shelf",billboard:"vertical",interpolation_duration:10,start_interpolation:0,transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[1.0f,1.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},view_range:24f,brightness:{block:15,sky:15}}

# 生成点比控制器高1.1格，因此必须用2格范围先捕获实体，之后使用唯一临时标签配置
tag @e[tag=lh.new_community] remove lh.new_community
tag @e[type=minecraft:item_display,nbt={data:{liars_holdem:{new_community:1b}}},distance=..2,sort=nearest,limit=1] add lh.new_community
execute unless entity @e[type=minecraft:item_display,tag=lh.new_community,limit=1] run function liars_holdem:log {text:"公共牌生成失败：未在2格范围捕获新item_display"}
execute unless entity @e[type=minecraft:item_display,tag=lh.new_community,limit=1] run return fail
tag @e[type=minecraft:item_display,tag=lh.new_community,limit=1] add lh.community
tag @e[type=minecraft:item_display,tag=lh.new_community,limit=1] add lh.game_entity
scoreboard players operation @e[type=minecraft:item_display,tag=lh.new_community,limit=1] lh_id = @s lh_id
scoreboard players operation @e[type=minecraft:item_display,tag=lh.new_community,limit=1] lh_card = @e[tag=lh.drawn,limit=1] lh_card
scoreboard players operation @e[type=minecraft:item_display,tag=lh.new_community,limit=1] lh_rank = @e[tag=lh.drawn,limit=1] lh_rank
scoreboard players operation @e[type=minecraft:item_display,tag=lh.new_community,limit=1] lh_suit = @e[tag=lh.drawn,limit=1] lh_suit
$scoreboard players set @e[type=minecraft:item_display,tag=lh.new_community,limit=1] lh_slot $(slot)
scoreboard players set @e[type=minecraft:item_display,tag=lh.new_community,limit=1] lh_flipped 0
function liars_holdem:community/configure_item with storage liars_holdem:card def
execute unless data entity @e[type=minecraft:item_display,tag=lh.new_community,limit=1] item.components."minecraft:item_model" run function liars_holdem:log {text:"公共牌模型写入失败：item_model组件不存在"}
execute as @e[type=minecraft:item_display,tag=lh.new_community,limit=1] run data remove entity @s data.liars_holdem
tag @e[type=minecraft:item_display,tag=lh.new_community] remove lh.new_community
kill @e[tag=lh.drawn,limit=1]
tag @e[tag=lh.drawn] remove lh.drawn
