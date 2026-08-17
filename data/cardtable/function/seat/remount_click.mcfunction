# 已有牌桌身份不变，仅允许玩家重新坐回自己原本的桌号和座位号
scoreboard players operation #clicked_id ct_ctx = @e[tag=ct.clicked_seat,limit=1] ct_id
scoreboard players operation #clicked_seat ct_ctx = @e[tag=ct.clicked_seat,limit=1] ct_seat
scoreboard players set #own_seat ct_ctx 0
execute if score @s ct_id = #clicked_id ct_ctx if score @s ct_seat = #clicked_seat ct_ctx run scoreboard players set #own_seat ct_ctx 1
execute unless score #own_seat ct_ctx matches 1 run tellraw @s [{text:'[牌桌] ',color:'dark_aqua'},{text:'游戏中只能坐回自己的原座位。',color:'red'}]
execute if score #own_seat ct_ctx matches 1 run function cardtable:seat/mount
