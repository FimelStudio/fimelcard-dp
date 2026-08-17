# 当前执行者就是execute summon刚创建的物品展示实体
# 金粒作为临时子弹外观；以后有资源包模型时只需统一替换此处item
$data merge entity @s {item:{id:"minecraft:gold_nugget",count:1,components:{"minecraft:item_name":"子弹"}},item_display:"ground",Rotation:[$(rot),0f],view_range:18f,brightness:{block:15,sky:15},transformation:{translation:[$(x),0.0f,$(z)],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.28f,0.28f,0.28f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
tag @s add lh.bullet_hud
tag @s add lh.game_entity
scoreboard players operation @s lh_id = #ctx_id lh_ctx
$scoreboard players set @s lh_slot $(seat)
