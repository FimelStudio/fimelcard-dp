scoreboard players operation #seat bw_ctx = #action bw_ctx
scoreboard players remove #seat bw_ctx 300
execute if score @s bw_seat = #seat bw_ctx run tellraw @s [{text:'[瞎掰王] ',color:'yellow'},{text:'不能指认自己。',color:'red'}]
execute if score @s bw_seat = #seat bw_ctx run return 0
tag @a[tag=bw.guess] remove bw.guess
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx if score @s bw_seat = #seat bw_ctx run tag @s add bw.guess
execute unless entity @a[tag=bw.guess,limit=1] run tellraw @s [{text:'[瞎掰王] ',color:'yellow'},{text:'该座位没有玩家。',color:'red'}]
execute unless entity @a[tag=bw.guess,limit=1] run return 0
# 后续结算会修改回合数与控制器状态，必须切换到当前牌桌控制器执行。
execute as @e[type=minecraft:marker,tag=bw.controller,scores={bw_state=2}] at @s if score @s bw_id = #ctx bw_ctx run function bullshit:round/resolve
