scoreboard players operation @s gd_count -= #played gd_ctx
data modify entity @s data.last_play set from entity @e[tag=gd.current,limit=1] data.guandan.action.cardtypes
data modify entity @s data.last_label set from entity @e[tag=gd.current,limit=1] data.guandan.action.label
execute unless score @s gd_count matches 0 run return 0
scoreboard players add @e[tag=gd.current,limit=1] gd_done 1
scoreboard players operation @s gd_rank = @e[tag=gd.current,limit=1] gd_done
tellraw @a[tag=gd.audience] [{text:"[掼蛋] ",color:"gold"},{nbt:"data.gd_name",entity:"@s",interpret:true,color:"aqua"},{text:" 出完手牌，取得第"},{score:{name:"@s",objective:"gd_rank"}},{text:"名。"}]
