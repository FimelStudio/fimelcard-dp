# 重置分数

scoreboard players reset @s fca_timer_total

# 添加标签

tag @s add fimel.anim_text.positional.animation.drop

# 更新参数

data modify entity @s teleport_duration set value 4

# 执行掉落

execute at @s run summon item ~ ~ ~ {Item:{id:"stone",count:1,components:{max_stack_size:1,item_model:"air",item_name:{text:""},damage_resistant:{types:"#fimel_anim_text:resist"}}},OnGround:0b,Tags:["fimel.anim_text.positional.animation.temp"],PickupDelay:-1,Age:-32768}

ride @s mount @e[type=item,limit=1,tag=fimel.anim_text.positional.animation.temp]

execute as @e[type=item,limit=1,tag=fimel.anim_text.positional.animation.temp] run function fimel_anim_text:positional/animation/process/item/init

# 中心实体加分

scoreboard players operation #entity.current fca_store = @s fca_id

execute as @e[type=text_display,tag=fimel.anim_text.positional.animation.center] if score @s fca_id = #entity.current fca_store run scoreboard players add @s fca_timer 1

# 音效

execute store result score #operation.sound fca_store run data get storage fimel_anim_text:runtime positional.animation.sound

execute at @s run function fimel_anim_text:operation/sound/positional_drop