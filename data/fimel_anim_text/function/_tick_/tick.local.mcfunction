## 本地动画播放

execute if entity @s[tag=fimel.anim_text.local.actionbar] run return run function fimel_anim_text:local/actionbar/process/tick

execute if entity @s[tag=fimel.anim_text.local.subtitle] run return run function fimel_anim_text:local/subtitle/process/tick

execute if entity @s[tag=fimel.anim_text.local.title] run return run function fimel_anim_text:local/title/process/tick