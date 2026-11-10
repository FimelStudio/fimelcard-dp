$tellraw @a[tag=ma.audience] [{"text":"[胡闹运动会] ","color":"gold"},{"nbt":"data.magical_athlete.p$(owner).name","entity":"@s","interpret":true},{"text":" · $(label)","color":"aqua"}]
$execute as @a[tag=ma.audience,scores={ma_side=$(owner)}] run function magical_athlete:feedback/subtitle {"text":{"text":"轮到你回应：查看下方操作提示","color":"aqua"}}
$execute as @a[tag=ma.audience,scores={ma_side=$(owner)}] run function magical_athlete:hud/notice {"text":{"text":"$(label)","color":"aqua"}}
