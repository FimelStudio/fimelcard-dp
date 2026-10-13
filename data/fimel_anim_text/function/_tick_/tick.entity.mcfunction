execute if entity @s[type=interaction] run return run function fimel_anim_text:_tick_/tick.local

execute if entity @s[tag=fimel.anim_text.positional] run return run function fimel_anim_text:_tick_/tick.positional

execute if entity @s[tag=fimel.anim_text.storage] run function fimel_anim_text:storage/output/process/tick