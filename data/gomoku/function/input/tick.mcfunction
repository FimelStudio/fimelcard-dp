# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 精确消费 interaction 记录，最大延迟一刻；不靠“最近的格子”猜测点击目标。
execute as @e[type=minecraft:interaction,tag=gm.cell] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] if data entity @s interaction at @s run function gomoku:input/cell
execute as @a[tag=gm.player,scores={gm_drop=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function gomoku:input/drop
execute as @a[tag=gm.player,scores={gm_action=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function gomoku:input/submit
execute as @a[scores={gm_settings=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function gomoku:settings/save
execute as @a[tag=gm.player,scores={gm_coord=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function gomoku:input/coordinate_submit
