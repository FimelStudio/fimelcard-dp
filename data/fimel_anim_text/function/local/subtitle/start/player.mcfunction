# 增加标签

tag @s add fimel.anim_text.local.subtitle

# 标题时常变更

title @s times 0 70 20

# 设置UUID

data modify storage fimel_anim_text:runtime local.subtitle.player.timestamp set value 0

data modify storage fimel_anim_text:runtime local.subtitle.player.player set from entity @s UUID

# 生成实体

execute positioned .0 400.0 .0 summon interaction run function fimel_anim_text:local/subtitle/start/summon