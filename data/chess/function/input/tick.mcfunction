# 精确消费 interaction 记录，最大延迟一刻；不靠“最近的格子”猜测点击目标。
execute as @e[type=minecraft:interaction,tag=ch.cell] if data entity @s interaction at @s run function chess:input/cell
execute as @a[tag=ch.player,scores={ch_drop=1..}] at @s run function chess:input/drop
execute as @a[tag=ch.player,scores={ch_action=1..}] at @s run function chess:input/submit
execute as @a[scores={ch_settings=1..}] at @s run function chess:settings/save
