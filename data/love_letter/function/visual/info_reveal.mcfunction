execute store result score #vis_role ll_ctx run data get entity @s data.ll_reveal
data modify storage love_letter:visual info.lines append value {text:" · ",color:"gray"}
execute if score #vis_role ll_ctx matches 0 run data modify storage love_letter:visual info.lines append value {"text":"间谍","color":"white"}
execute if score #vis_role ll_ctx matches 1 run data modify storage love_letter:visual info.lines append value {"text":"侍卫","color":"white"}
execute if score #vis_role ll_ctx matches 2 run data modify storage love_letter:visual info.lines append value {"text":"牧师","color":"white"}
execute if score #vis_role ll_ctx matches 3 run data modify storage love_letter:visual info.lines append value {"text":"男爵","color":"white"}
execute if score #vis_role ll_ctx matches 4 run data modify storage love_letter:visual info.lines append value {"text":"侍女","color":"white"}
execute if score #vis_role ll_ctx matches 5 run data modify storage love_letter:visual info.lines append value {"text":"王子","color":"white"}
execute if score #vis_role ll_ctx matches 6 run data modify storage love_letter:visual info.lines append value {"text":"大臣","color":"white"}
execute if score #vis_role ll_ctx matches 7 run data modify storage love_letter:visual info.lines append value {"text":"国王","color":"white"}
execute if score #vis_role ll_ctx matches 8 run data modify storage love_letter:visual info.lines append value {"text":"女爵","color":"white"}
execute if score #vis_role ll_ctx matches 9 run data modify storage love_letter:visual info.lines append value {"text":"公主","color":"white"}
