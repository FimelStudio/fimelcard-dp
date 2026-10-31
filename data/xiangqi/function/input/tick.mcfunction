# 精确消费 interaction 记录，最大延迟一刻；不靠“最近的格子”猜测点击目标。
execute as @e[type=minecraft:interaction,tag=xq.cell] if data entity @s interaction at @s run function xiangqi:input/cell
execute as @a[tag=xq.player,scores={xq_drop=1..}] at @s run function xiangqi:input/drop
execute as @a[tag=xq.player,scores={xq_action=1..}] at @s run function xiangqi:input/submit
execute as @a[scores={xq_settings=1..}] at @s run function xiangqi:settings/save
