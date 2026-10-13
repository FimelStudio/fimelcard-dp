# 添加标签

tag @s add fimel.anim_text.local.actionbar

# 设置UUID

data modify storage fimel_anim_text:runtime local.actionbar.player.timestamp set value 0

data modify storage fimel_anim_text:runtime local.actionbar.player.player set from entity @s UUID

# 生成实体

execute positioned .0 400.0 .0 summon interaction run function fimel_anim_text:local/actionbar/start/summon