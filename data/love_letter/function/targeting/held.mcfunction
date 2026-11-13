scoreboard players set #held ll_ctx -1
execute if data entity @s SelectedItem.components."minecraft:custom_data".love_letter{hand:1b} store result score #held ll_ctx run data get entity @s SelectedItem.components."minecraft:custom_data".love_letter.card
execute if score @e[tag=ll.current,limit=1] ll_target_mode matches 1 unless score #held ll_ctx matches 4 run return 0
execute if score #held ll_ctx matches 4 run scoreboard players operation #aim ll_ctx = #actor ll_ctx
execute if score #held ll_ctx matches 5 if score #aim ll_ctx matches 0 run scoreboard players operation #aim ll_ctx = #actor ll_ctx
execute unless score #held ll_ctx matches 1..5 unless score #held ll_ctx matches 7 run return 0
execute if score @s ll_hintwait matches 1.. run return 0
execute unless score #held ll_ctx matches 4 if score #blocked ll_ctx matches 1 run return run title @s actionbar {text:"该玩家已出局或受侍女保护，请选择其他玩家。",color:"yellow"}
function love_letter:targeting/hint
