execute as @e[tag=ll.current,limit=1] run function love_letter:targeting/selection_context
scoreboard players set #aim ll_ctx 0
execute if data entity @s SelectedItem.components."minecraft:custom_data".love_letter{head:1b} run data modify storage love_letter:input preview set from entity @s SelectedItem.components."minecraft:custom_data".love_letter
execute if data entity @s SelectedItem.components."minecraft:custom_data".love_letter{head:1b} run function love_letter:targeting/head_preview_validate with storage love_letter:input preview
scoreboard players set #head_legal ll_ctx 0
execute as @e[tag=ll.legal] if score @s ll_seat = #aim ll_ctx run scoreboard players set #head_legal ll_ctx 1
scoreboard players set #unavailable ll_ctx 0
execute unless score #head_legal ll_ctx matches 1 run scoreboard players set #unavailable ll_ctx 1
execute if score #aim ll_ctx matches 1..8 run function love_letter:targeting/hint
execute if score #aim ll_ctx matches 0 unless score @s ll_hintwait matches 1.. run title @s actionbar {text:"请选择玩家头颅，按 Q 指定目标；最后一格 Q 取消。",color:"yellow"}
execute unless score #head_legal ll_ctx matches 1 run scoreboard players set #aim ll_ctx 0
