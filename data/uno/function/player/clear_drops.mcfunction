# 新操作物将桌号写入 custom_data，即使 origin 已离线仍能精确清理。
$execute as @e[type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{uno:{tool:1b,table:$(table)}}] run kill @s
