# 检测掉落

execute if entity @s[tag=fimel.anim_text.positional.animation.drop.onground] run return run function fimel_anim_text:positional/animation/process/fade/main

# 空中视角随机

execute on vehicle positioned as @s positioned ~ ~0.01 ~ if data entity @s {OnGround:1b} on passengers rotated as @s run function fimel_anim_text:positional/animation/process/drop/kill_item

execute if entity @s[tag=fimel.anim_text.positional.animation.drop.billboard] run return fail

scoreboard players add @s fca_timer 1

scoreboard players operation @s fca_timer %= #value.4 fca_store

execute if score @s fca_timer matches 0 store result entity @s Rotation[0] float 0.001 run random value -180000..180000