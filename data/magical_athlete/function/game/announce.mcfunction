$tellraw @a[tag=ma.audience] [{text:"获胜：",color:"gold"},{nbt:"data.magical_athlete.p$(side).name",entity:"@s",interpret:true},{text:" · ",color:"gray"},{nbt:"data.magical_athlete.p$(side).points",entity:"@s"},{text:"分",color:"gray"}]
$execute as @a[tag=ma.audience,scores={ma_side=$(side)}] at @s run function magical_athlete:game/firework
# feedback-v1
$execute as @a[tag=ma.audience,scores={ma_side=$(side)}] run function magical_athlete:feedback/subtitle {"text":{"text":"胡闹运动会总冠军！","color":"gold"}}
