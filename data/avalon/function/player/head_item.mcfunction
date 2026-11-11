$execute if items entity @s hotbar.$(slot) *[minecraft:custom_data~{avalon:{head:1b,table:$(table),epoch:$(epoch),seat:$(seat)}}] run return 0
$clear @s *[minecraft:custom_data~{avalon:{head:1b,table:$(table),epoch:$(epoch),seat:$(seat)}}]
$execute if items entity @s hotbar.$(slot) *[minecraft:custom_data~{avalon:{head:1b}}] run item replace entity @s hotbar.$(slot) with minecraft:air
scoreboard players set #head_moved av_ctx 0
$execute if items entity @s hotbar.$(slot) * store success score #head_moved av_ctx run function avalon:player/head_make_room with storage avalon:heads
$execute if score #head_moved av_ctx matches 1 run item replace entity @s hotbar.$(slot) with minecraft:air
$execute if items entity @s hotbar.$(slot) * run return run scoreboard players set #head_blocked av_ctx 1
$item replace entity @s hotbar.$(slot) with minecraft:player_head[minecraft:profile={id:$(uuid)},minecraft:item_name=[$(name),{text:" · Q选中／取消"}],minecraft:custom_data={avalon:{head:1b,table:$(table),epoch:$(epoch),seat:$(seat)}},minecraft:max_stack_size=1]
