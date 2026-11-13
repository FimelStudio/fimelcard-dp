# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$item replace entity @s hotbar.8 with minecraft:lime_dye[minecraft:item_name='结束问答并指认（Q选择玩家）',minecraft:custom_data={bullshit:{card:1b,kind:'guess',table:$(table)}},minecraft:enchantment_glint_override=true,minecraft:max_stack_size=1]
