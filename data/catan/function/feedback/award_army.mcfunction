$execute unless predicate {condition:"minecraft:value_check",value:$(army),range:{min:1,max:4}} run return 0
$tellraw @a[tag=ca.audience] [{"text":"[卡坦岛] ","color":"gold"},{"nbt":"data.catan.p$(army).name","entity":"@s","interpret":true},{"text":" 获得最大骑士军（2分）。","color":"gold"}]
$execute as @a[tag=ca.audience,scores={ca_side=$(army)}] run function catan:feedback/subtitle {"text":{"text":"获得最大骑士军！","color":"gold"}}
