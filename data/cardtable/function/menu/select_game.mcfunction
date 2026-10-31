# 玩家提交已由picker/handle验证；再次选择当前游戏不重置原设置。
execute if score @s ct_game = #pick_choice ct_ctx run return 0
execute if score @s ct_game matches 11 run function uno:settings/invalidate_table
execute if score @s ct_game matches 12 run function chess:game/remove
execute if score @s ct_game matches 13 run function xiangqi:game/remove
execute if score @s ct_game matches 14 run function gomoku:game/remove
execute if score @s ct_game matches 15 run function aeroplane_chess:game/remove
scoreboard players operation @s ct_game = #pick_choice ct_ctx
scoreboard players operation #ctx_id ct_ctx = @s ct_id
# 其他人的旧窗口也失效，防止覆盖刚刚选定的游戏。
execute as @a if score @s ct_pick_table = #ctx_id ct_ctx run scoreboard players reset @s ct_pick_table
# 四座和八座桌都开放全部游戏；人数由各游戏单独校验。
execute if score @s ct_game matches 1 run tellraw @a[tag=ct.switch_actor,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'已选择：',color:'gray'},{text:'Fast Card',color:'gold'}]
execute if score @s ct_game matches 1 run function cardtable:log {text:"切换游戏：Fast Card"}
execute if score @s ct_game matches 2 run tellraw @a[tag=ct.switch_actor,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'已选择：',color:'gray'},{text:'赌命德州扑克',color:'red'}]
execute if score @s ct_game matches 2 run function cardtable:log {text:"切换游戏：赌命德州扑克"}
execute if score @s ct_game matches 3 run tellraw @a[tag=ct.switch_actor,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'已选择：',color:'gray'},{text:'花火',color:'light_purple'}]
execute if score @s ct_game matches 3 run function cardtable:log {text:"切换游戏：花火"}
execute if score @s ct_game matches 4 run tellraw @a[tag=ct.switch_actor,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'已选择：',color:'gray'},{text:'出包魔法师',color:'dark_purple'}]
execute if score @s ct_game matches 4 run function cardtable:log {text:"切换游戏：出包魔法师"}
execute if score @s ct_game matches 5 run tellraw @a[tag=ct.switch_actor,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'已选择：',color:'gray'},{text:'瞎掰王',color:'yellow'}]
execute if score @s ct_game matches 5 run function cardtable:log {text:"切换游戏：瞎掰王"}
execute if score @s ct_game matches 6 run tellraw @a[tag=ct.switch_actor,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'已选择：',color:'gray'},{text:'谍报风云',color:'aqua'}]
execute if score @s ct_game matches 6 run function cardtable:log {text:"切换游戏：谍报风云"}
execute if score @s ct_game matches 7 run tellraw @a[tag=ct.switch_actor,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'已选择：',color:'gray'},{text:'临界点',color:'red'}]
execute if score @s ct_game matches 7 run function cardtable:log {text:"切换游戏：临界点"}
execute if score @s ct_game matches 8 run tellraw @a[tag=ct.switch_actor,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'已选择：问非所答',color:'gold'}]
execute if score @s ct_game matches 9 run tellraw @a[tag=ct.switch_actor,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'已选择：骷髅牌',color:'gold'}]
execute if score @s ct_game matches 8 run function cardtable:log {text:"切换游戏：问非所答"}
execute if score @s ct_game matches 9 run function cardtable:log {text:"切换游戏：骷髅牌"}
execute if score @s ct_game matches 10 run tellraw @a[tag=ct.switch_actor,limit=1] [{text:"[牌桌] ",color:"dark_aqua"},{text:"已选择：斗地主",color:"gold"}]
execute if score @s ct_game matches 10 run function cardtable:log {text:"切换游戏：斗地主"}
execute if score @s ct_game matches 11 run tellraw @a[tag=ct.switch_actor,limit=1] [{text:"[牌桌] ",color:"dark_aqua"},{text:"已选择：UNO",color:"red"}]
execute if score @s ct_game matches 11 run function cardtable:log {text:"切换游戏：UNO"}
execute if score @s ct_game matches 12 run tellraw @a[tag=ct.switch_actor,limit=1] {text:"[牌桌] 已选择：国际象棋",color:"gold"}
execute if score @s ct_game matches 13 run tellraw @a[tag=ct.switch_actor,limit=1] {text:"[牌桌] 已选择：中国象棋",color:"gold"}
execute if score @s ct_game matches 14 run tellraw @a[tag=ct.switch_actor,limit=1] {text:"[牌桌] 已选择：五子棋",color:"gold"}
execute if score @s ct_game matches 14 run function cardtable:log {text:"切换游戏：五子棋"}
execute if score @s ct_game matches 15 run tellraw @a[tag=ct.switch_actor,limit=1] {text:"[牌桌] 已选择：飞行棋",color:"gold"}
execute if score @s ct_game matches 15 run function cardtable:log {text:"切换游戏：飞行棋"}
function cardtable:game/init_selected
function cardtable:menu/render
