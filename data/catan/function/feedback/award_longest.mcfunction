$execute unless predicate {condition:"minecraft:value_check",value:$(longest),range:{min:1,max:4}} run return 0
$tellraw @a[tag=ca.audience] [{"text":"[卡坦岛] ","color":"gold"},{"nbt":"data.catan.p$(longest).name","entity":"@s","interpret":true},{"text":" 获得最长道路（2分）。","color":"gold"}]
$execute as @a[tag=ca.audience,scores={ca_side=$(longest)}] run function catan:feedback/subtitle {"text":{"text":"获得最长道路！","color":"gold"}}
