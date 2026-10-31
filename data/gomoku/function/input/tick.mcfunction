# 精确消费 interaction 记录，最大延迟一刻；不靠“最近的格子”猜测点击目标。
execute as @e[type=minecraft:interaction,tag=gm.cell] if data entity @s interaction at @s run function gomoku:input/cell
execute as @a[tag=gm.player,scores={gm_drop=1..}] at @s run function gomoku:input/drop
execute as @a[tag=gm.player,scores={gm_action=1..}] at @s run function gomoku:input/submit
execute as @a[scores={gm_settings=1..}] at @s run function gomoku:settings/save
execute as @a[tag=gm.player,scores={gm_coord=1..}] at @s run function gomoku:input/coordinate_submit
