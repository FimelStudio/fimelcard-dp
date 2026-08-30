execute if score @s bw_used matches 1 run return 0
scoreboard players operation #seat bw_ctx = #action bw_ctx
scoreboard players remove #seat bw_ctx 400
execute if score @s bw_seat = #seat bw_ctx run tellraw @s [{text:'[瞎掰王] ',color:'yellow'},{text:'不能对自己使用功能牌。',color:'red'}]
execute if score @s bw_seat = #seat bw_ctx run return 0
execute unless entity @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx if score @s bw_seat = #seat bw_ctx run tellraw @s [{text:'[瞎掰王] ',color:'yellow'},{text:'该座位没有玩家。',color:'red'}]
execute unless entity @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx if score @s bw_seat = #seat bw_ctx run return 0
scoreboard players set @a[tag=bw.player] bw_bs 0
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx if score @s bw_seat = #seat bw_ctx run scoreboard players set @s bw_bs 1
scoreboard players set @s bw_used 1
clear @s minecraft:paper[minecraft:custom_data~{bullshit:{card:1b,kind:'call'}}]
tellraw @a[tag=bw.player] [{text:'[净他喵扯淡！] ',color:'red'},{selector:'@s',color:'gold'},{text:'质疑了 ',color:'gray'},{selector:'@a[tag=bw.player,scores={bw_bs=1},limit=1]',color:'yellow'},{text:'，将在结算时揭晓。',color:'gray'}]
