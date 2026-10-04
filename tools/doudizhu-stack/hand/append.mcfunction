$execute unless score #previous dd_ctx matches $(rank) run scoreboard players set #depth dd_ctx 0
$execute if score #previous dd_ctx matches $(rank) run data modify storage doudizhu:ui hand.extra append value {text:"\uE000",font:"card:doudizhu/spacing"}
$execute unless score #previous dd_ctx matches 0 unless score #previous dd_ctx matches $(rank) run data modify storage doudizhu:ui hand.extra append value {text:"\uE001",font:"card:doudizhu/spacing"}
$data modify storage doudizhu:ui piece set value {text:"$(glyph)",font:"card:doudizhu/hand_0",shadow_color:0}
execute if score #depth dd_ctx matches 0 run data modify storage doudizhu:ui piece.font set value "card:doudizhu/hand_0"
execute if score #depth dd_ctx matches 0 if score @s dd_selected matches 1 run data modify storage doudizhu:ui piece.font set value "card:doudizhu/hand_selected_0"
execute if score #depth dd_ctx matches 1 run data modify storage doudizhu:ui piece.font set value "card:doudizhu/hand_1"
execute if score #depth dd_ctx matches 1 if score @s dd_selected matches 1 run data modify storage doudizhu:ui piece.font set value "card:doudizhu/hand_selected_1"
execute if score #depth dd_ctx matches 2 run data modify storage doudizhu:ui piece.font set value "card:doudizhu/hand_2"
execute if score #depth dd_ctx matches 2 if score @s dd_selected matches 1 run data modify storage doudizhu:ui piece.font set value "card:doudizhu/hand_selected_2"
execute if score #depth dd_ctx matches 3 run data modify storage doudizhu:ui piece.font set value "card:doudizhu/hand_3"
execute if score #depth dd_ctx matches 3 if score @s dd_selected matches 1 run data modify storage doudizhu:ui piece.font set value "card:doudizhu/hand_selected_3"
data modify storage doudizhu:ui hand.extra append from storage doudizhu:ui piece
$data modify storage doudizhu:ui button set value {rank:$(rank),label:{text:"$(glyph)",font:"card:doudizhu/stack",shadow_color:0},tooltip:{text:"$(name) · 点击选择／取消"},slices:$(slices),action:{type:"minecraft:run_command",command:"trigger dd_action set $(id)"}}
execute if score @s dd_selected matches 1 run data modify storage doudizhu:ui button.label.font set value "card:doudizhu/stack_selected"
data modify storage doudizhu:ui buttons append from storage doudizhu:ui button
$scoreboard players set #previous dd_ctx $(rank)
scoreboard players add #depth dd_ctx 1
scoreboard players add #count dd_ctx 1
