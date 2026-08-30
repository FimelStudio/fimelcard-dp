scoreboard objectives add bw_ctx dummy
execute unless score #version bw_ctx matches 1.. run function bullshit:system/install
execute if score #version bw_ctx matches 1 run function bullshit:system/upgrade_v2
tellraw @a[tag=bw.player] [{text:'[瞎掰王] ',color:'yellow'},{text:'数据包已重新加载，当前游戏将安全结束。',color:'yellow'}]
execute as @e[type=minecraft:marker,tag=bw.controller] at @s run function bullshit:game/abort
