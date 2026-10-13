tp @s ^ ^ ^

# 结束跳出

execute unless data storage fimel_anim_text:runtime positional.animation.input[0] run return run kill @s

# 刷新文本

function fimel_anim_text:positional/animation/start/marker/text

# 生成文本

execute summon text_display run function fimel_anim_text:positional/animation/start/summon_text/init_text

# 位移

function fimel_anim_text:positional/animation/start/marker/pos