# 调用前在桌心生成唯一带临时data的文本展示实体；本函数把文本交给公共动画适配器
data modify storage minecraft:cgt_anim_text positional.animation.data set value {analyse:0b,sound:0,speed:300,style:30,scale:1.15f,entity_properties:{billboard:"vertical",alignment:"center",line_width:220,background:0,shadow:1b,see_through:0b,view_range:20f,brightness:{block:15,sky:15}}}
data modify storage minecraft:cgt_anim_text positional.animation.data.text set value []
data modify storage minecraft:cgt_anim_text positional.animation.data.text append from entity @e[type=minecraft:text_display,nbt={data:{liars_holdem:{transition_template:1b}}},distance=..0.05,sort=nearest,limit=1] text
kill @e[type=minecraft:text_display,nbt={data:{liars_holdem:{transition_template:1b}}},distance=..0.05,sort=nearest,limit=1]
execute positioned ~ ~1.85 ~ rotated 0 0 run function cardtable:animation/text/load

# 绑定本次动画中心实体及其动画库实例，清理时按桌号和实例编号整组删除
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute positioned ~ ~1.85 ~ run scoreboard players operation @e[type=minecraft:text_display,tag=cgt_anim_text.positional.animation.center,tag=!lh.transition,distance=..0.05,sort=nearest,limit=1] lh_id = #ctx_id lh_ctx
execute positioned ~ ~1.85 ~ run tag @e[type=minecraft:text_display,tag=cgt_anim_text.positional.animation.center,tag=!lh.transition,distance=..0.05,sort=nearest,limit=1] add lh.transition
execute positioned ~ ~1.85 ~ run tag @e[type=minecraft:text_display,tag=cgt_anim_text.positional.animation.center,tag=lh.transition,distance=..0.05,sort=nearest,limit=1] add lh.transition.root
execute positioned ~ ~1.85 ~ as @e[type=minecraft:text_display,tag=lh.transition.root,distance=..0.05,sort=nearest,limit=1] run function liars_holdem:transition/enforce_vertical
