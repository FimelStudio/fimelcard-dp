tp @s ^ ^ ^

# 结束跳出

execute unless data storage fimel_anim_text:runtime positional.animation.input[0] run return run function fimel_anim_text:positional/animation/process/marker/stop

# 刷新文本

function fimel_anim_text:positional/animation/process/marker/text

# 计算下一刻时间

#function fimel_anim_text:positional/typewriter/process/punctuation

# 复制分数

scoreboard players operation #entity.current fca_store = @s fca_id

scoreboard players operation #positional.animation.time.max fca_store = @s fca_timer_max

scoreboard players operation #positional.animation.style fca_store = @s fca_style

#tellraw @a {storage:"fimel_anim_text:runtime",nbt:"positional.animation.sound"}

# 生成文本

execute summon text_display run function fimel_anim_text:positional/animation/process/summon_text/init_text