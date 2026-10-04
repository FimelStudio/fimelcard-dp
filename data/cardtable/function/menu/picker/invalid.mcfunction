scoreboard players reset @s ct_pick_table
scoreboard players reset @s ct_pick_base
tag @s remove ct.switch_actor
tag @e[tag=ct.switch_controller] remove ct.switch_controller
tellraw @s [{text:"[牌桌] ",color:"dark_aqua"},{text:"选择窗口已失效，请入座后重新点击“切换游戏”。",color:"yellow"}]
