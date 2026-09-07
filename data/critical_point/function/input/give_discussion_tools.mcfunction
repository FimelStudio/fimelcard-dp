scoreboard players operation #ctx cp_ctx = @s cp_id
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run item replace entity @s hotbar.7 with minecraft:red_dye[minecraft:item_name='发动唯一投票（Q）',minecraft:custom_data={critical_point:{tool:'vote'}},minecraft:enchantment_glint_override=true,minecraft:max_stack_size=1]
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run item replace entity @s hotbar.8 with minecraft:lime_dye[minecraft:item_name='准备下一轮（Q）',minecraft:custom_data={critical_point:{tool:'ready'}},minecraft:max_stack_size=1]
function critical_point:player/mark_audience
tellraw @a[tag=cp.audience] [{text:'现在可以讨论。任何人可按Q丢出红色染料发动整局唯一一次投票；若继续游戏，请按Q丢出绿色染料，全员准备后进入下一轮。',color:'yellow'}]
tag @a[tag=cp.audience] remove cp.audience

