$tellraw @a[tag=sp.audience] [{text:"获胜：",color:"gold"},{nbt:"data.splendor.p$(side).name",entity:"@s",interpret:true},{text:" · ",color:"gray"},{nbt:"data.splendor.p$(side).vp",entity:"@s"},{text:"分，",color:"gray"},{nbt:"data.splendor.p$(side).card_count",entity:"@s"},{text:"张开发卡",color:"gray"}]
$execute as @a[tag=sp.audience,scores={sp_side=$(side)}] at @s run function splendor:game/firework
