# Fast Card自己的中央抢按按钮：外观为展示实体，点击体仍是交互实体
function fast_card:table/clear_button
summon minecraft:block_display ~ ~1.01 ~ {data:{fast_card:{new_game_entity:1b,button_display:1b}},block_state:{id:'minecraft:polished_blackstone_button',properties:{face:'floor',facing:'north',powered:'false'}},transformation:{translation:[-0.75f,0.0f,-0.75f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[1.35f,1.35f,1.35f],right_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[1.5f,1.5f,1.5f]},view_range:24f,brightness:{block:15,sky:15}}
summon minecraft:interaction ~ ~0.96 ~ {data:{fast_card:{new_game_entity:1b,button:1b}},width:0.92f,height:0.48f,response:1b}

execute as @e[nbt={data:{fast_card:{new_game_entity:1b}}},distance=..2] run tag @s add fc.new_game_entity
tag @e[tag=fc.new_game_entity,distance=..2] add fc.game_entity
tag @e[tag=fc.new_game_entity,distance=..2] add fc.part
scoreboard players operation @e[tag=fc.new_game_entity,distance=..2] fc_id = @s fc_id
execute as @e[type=minecraft:interaction,nbt={data:{fast_card:{button:1b}}},distance=..2] run tag @s add fc.button
execute as @e[type=minecraft:block_display,nbt={data:{fast_card:{button_display:1b}}},distance=..2] run tag @s add fc.button_display
scoreboard players set @e[type=minecraft:interaction,tag=fc.button,distance=..2] fc_kind 1
execute as @e[tag=fc.new_game_entity,distance=..2] run data remove entity @s data.fast_card
tag @e[tag=fc.new_game_entity,distance=..2] remove fc.new_game_entity
