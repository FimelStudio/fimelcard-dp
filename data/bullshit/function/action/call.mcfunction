execute if score @s bw_used matches 1 run return 0
scoreboard players operation #seat bw_ctx = #action bw_ctx
scoreboard players remove #seat bw_ctx 400
execute if score @s bw_seat = #seat bw_ctx run return 0
tag @a[tag=bw.call_target] remove bw.call_target
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx if score @s bw_seat = #seat bw_ctx run tag @s add bw.call_target
execute unless entity @a[tag=bw.call_target,limit=1] run tellraw @s {text:"该座位没有玩家。",color:"red"}
execute unless entity @a[tag=bw.call_target,limit=1] run return 0
function bullshit:player/mark_audience
scoreboard players set @a[tag=bw.audience] bw_bs 0
scoreboard players set @a[tag=bw.call_target,limit=1] bw_bs 1
scoreboard players set @s bw_used 1
clear @s minecraft:paper[minecraft:custom_data~{bullshit:{card:1b,kind:'call'}}]
tellraw @a[tag=bw.audience] [{text:'[净他喵扯淡！] ',color:'red'},{selector:'@s',color:'gold'},{text:'质疑了 ',color:'gray'},{selector:'@a[tag=bw.call_target,limit=1]',color:'yellow'},{text:'，将在结算时揭晓。',color:'gray'}]
tag @a[tag=bw.call_target] remove bw.call_target
tag @a[tag=bw.audience] remove bw.audience
