# 游戏编号循环递增
scoreboard players add @s ct_game 1
execute if score @s ct_game > #game_count ct_ctx run scoreboard players set @s ct_game 1
execute if score @s ct_game matches 1 run tellraw @a[tag=ct.switch_actor,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'已选择：',color:'gray'},{text:'Fast Card',color:'gold'}]
execute if score @s ct_game matches 1 run function cardtable:log {text:"切换游戏：Fast Card"}
execute if score @s ct_game matches 2 run tellraw @a[tag=ct.switch_actor,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'已选择：',color:'gray'},{text:'赌命德州扑克',color:'red'}]
execute if score @s ct_game matches 2 run function cardtable:log {text:"切换游戏：赌命德州扑克"}
execute if score @s ct_game matches 3 run tellraw @a[tag=ct.switch_actor,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'已选择：',color:'gray'},{text:'花火',color:'light_purple'}]
execute if score @s ct_game matches 3 run function cardtable:log {text:"切换游戏：花火"}
execute if score @s ct_game matches 4 run tellraw @a[tag=ct.switch_actor,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'已选择：',color:'gray'},{text:'出包魔法师',color:'dark_purple'}]
execute if score @s ct_game matches 4 run function cardtable:log {text:"切换游戏：出包魔法师"}
function cardtable:game/init_selected
function cardtable:menu/render
