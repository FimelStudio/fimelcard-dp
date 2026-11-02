# 只重建本桌的中央菜单，更新发生在入座、离座和牌局结束时
scoreboard players operation #ctx_id ct_ctx = @s ct_id
execute as @e[tag=ct.menu] if score @s ct_id = #ctx_id ct_ctx run kill @s
# 旧版本或外部修改留下的异常编号回退到首个已注册游戏，不显示“未注册游戏”。
execute unless score @s ct_game matches 1..21 run scoreboard players set @s ct_game 1

# 菜单由文字展示实体负责显示，由同位置的交互实体负责点击
# 26.2的text_display不可在世界内被选取，文本click_event不能替代此点击层
# 三个操作行的点击区统一为1.30×0.20，避免较宽的上方点击区沿玩家视线遮挡下方按钮
execute if score @s ct_game matches 1 run function cardtable:menu/game_name_fast_card
execute if score @s ct_game matches 2 run function cardtable:menu/game_name_liars_holdem
execute if score @s ct_game matches 3 run function cardtable:menu/game_name_hanabi
execute if score @s ct_game matches 4 run function cardtable:menu/game_name_abraca
execute if score @s ct_game matches 5 run function cardtable:menu/game_name_bullshit
execute if score @s ct_game matches 6 run function cardtable:menu/game_name_decrypto
execute if score @s ct_game matches 7 run function cardtable:menu/game_name_critical_point
execute if score @s ct_game matches 8 run function cardtable:menu/game_name_wenfei
execute if score @s ct_game matches 9 run function cardtable:menu/game_name_skull
execute if score @s ct_game matches 10 run function cardtable:menu/game_name_doudizhu
execute if score @s ct_game matches 11 run function cardtable:menu/game_name_uno
execute if score @s ct_game matches 12 run function cardtable:menu/game_name_chess
execute if score @s ct_game matches 13 run function cardtable:menu/game_name_xiangqi
execute if score @s ct_game matches 14 run function cardtable:menu/game_name_gomoku
execute if score @s ct_game matches 15 run function cardtable:menu/game_name_aeroplane_chess
execute if score @s ct_game matches 16 run function cardtable:menu/game_name_avalon
execute if score @s ct_game matches 17 run function cardtable:menu/game_name_love_letter
execute if score @s ct_game matches 18 run function cardtable:menu/game_name_guandan
execute if score @s ct_game matches 20 run function cardtable:menu/game_name_weiqi
execute if score @s ct_game matches 19 run function cardtable:menu/game_name_ito
execute if score @s ct_game matches 21 run function cardtable:menu/game_name_catan
execute unless score @s ct_capacity matches 4 unless score @s ct_capacity matches 8 run scoreboard players set @s ct_capacity 4
execute store result storage cardtable:menu people int 1 run scoreboard players get @s ct_joined
execute store result storage cardtable:menu capacity int 1 run scoreboard players get @s ct_capacity
function cardtable:menu/people with storage cardtable:menu
summon minecraft:text_display ~ ~2.30 ~ {data:{cardtable:{new_ui:1b}},text:[{text:'◀',color:'yellow'},{text:' 切换游戏 ',color:'aqua'},{text:'▶',color:'yellow'}],billboard:'vertical',alignment:'center',line_width:200,background:0,shadow:1b,see_through:0b,view_range:24f,brightness:{block:15,sky:15}}
summon minecraft:interaction ~ ~2.20 ~ {data:{cardtable:{new_ui:1b,switch_game:1b}},width:1.30f,height:0.20f,response:1b}
summon minecraft:text_display ~ ~1.95 ~ {data:{cardtable:{new_ui:1b}},text:{text:'[ 游戏设置 ]',color:'light_purple',bold:true},billboard:'vertical',alignment:'center',line_width:200,background:0,shadow:1b,see_through:0b,view_range:24f,brightness:{block:15,sky:15}}
summon minecraft:interaction ~ ~1.85 ~ {data:{cardtable:{new_ui:1b,game_settings:1b}},width:1.30f,height:0.20f,response:1b}
summon minecraft:text_display ~ ~1.60 ~ {data:{cardtable:{new_ui:1b}},text:{text:'[ 开始游戏 ]',color:'green',bold:true},billboard:'vertical',alignment:'center',line_width:200,background:0,shadow:1b,see_through:0b,view_range:24f,brightness:{block:15,sky:15}}
summon minecraft:interaction ~ ~1.50 ~ {data:{cardtable:{new_ui:1b,start_game:1b}},width:1.30f,height:0.20f,response:1b}

# 把临时data用途转换为运行期标签和记分
execute as @e[nbt={data:{cardtable:{new_ui:1b}}},distance=..3] run tag @s add ct.new_ui
tag @e[tag=ct.new_ui,distance=..3] add ct.menu
tag @e[tag=ct.new_ui,distance=..3] add ct.part
scoreboard players operation @e[tag=ct.new_ui,distance=..3] ct_id = @s ct_id
execute as @e[type=minecraft:interaction,nbt={data:{cardtable:{switch_game:1b}}},distance=..3] run scoreboard players set @s ct_kind 21
execute as @e[type=minecraft:interaction,nbt={data:{cardtable:{start_game:1b}}},distance=..3] run scoreboard players set @s ct_kind 22
execute as @e[type=minecraft:interaction,nbt={data:{cardtable:{game_settings:1b}}},distance=..3] run scoreboard players set @s ct_kind 23
execute as @e[tag=ct.new_ui,distance=..3] run data remove entity @s data.cardtable
tag @e[tag=ct.new_ui,distance=..3] remove ct.new_ui

# 控制器记录界面结构版本，避免维护循环重复重建
