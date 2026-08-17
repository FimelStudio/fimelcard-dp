# 实体Pos保持桌心不变，只插值修改translation；后续翻牌只修改right_rotation
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @e[type=minecraft:item_display,tag=lh.community,scores={lh_slot=1}] if score @s lh_id = #ctx_id lh_ctx run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{translation:[-1.0f,0.0f,0.0f]}}
execute as @e[type=minecraft:item_display,tag=lh.community,scores={lh_slot=2}] if score @s lh_id = #ctx_id lh_ctx run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{translation:[-0.5f,0.0f,0.0f]}}
execute as @e[type=minecraft:item_display,tag=lh.community,scores={lh_slot=3}] if score @s lh_id = #ctx_id lh_ctx run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{translation:[0.0f,0.0f,0.0f]}}
execute as @e[type=minecraft:item_display,tag=lh.community,scores={lh_slot=4}] if score @s lh_id = #ctx_id lh_ctx run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{translation:[0.5f,0.0f,0.0f]}}
execute as @e[type=minecraft:item_display,tag=lh.community,scores={lh_slot=5}] if score @s lh_id = #ctx_id lh_ctx run data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{translation:[1.0f,0.0f,0.0f]}}
function liars_holdem:sound/community_spread
function liars_holdem:log {text:"五张公共牌开始从桌心横向展开"}
