scoreboard players set #minus_one dd_ctx -1
scoreboard players operation #pair_points dd_ctx *= #minus_one dd_ctx
tellraw @a[tag=dd.audience] [{text:"蓝队本副得 ",color:"blue"},{score:{name:"#pair_points",objective:"dd_ctx"}},{text:" 分。"}]
