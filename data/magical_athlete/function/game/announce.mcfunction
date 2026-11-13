$tellraw @a[tag=ma.audience] [{text:"获胜：",color:"gold"},{nbt:"data.magical_athlete.p$(side).name",entity:"@s",interpret:true},{text:" · ",color:"gray"},{nbt:"data.magical_athlete.p$(side).points",entity:"@s"},{text:"分",color:"gray"}]
$function cardtable:game/result/append_name {path:"data.magical_athlete.p$(side).name"}
$execute as @a[tag=ma.audience,scores={ma_side=$(side)}] at @s run function magical_athlete:game/firework
