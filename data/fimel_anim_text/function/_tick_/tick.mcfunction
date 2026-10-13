## 全局动画播放

function fimel_anim_text:_tick_/tick.global

## 本地动画播放 | 展示实体播放 | 存储文本打字

execute as @e[type=#fimel_anim_text:positional] if entity @s[tag=fimel.anim_text.mark] run function fimel_anim_text:_tick_/tick.entity

## 调试

#function fimel_anim_text:_debug_/anim