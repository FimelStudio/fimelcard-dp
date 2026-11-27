# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 仅扫描即时输入。设置窗口只在打开后启用 trigger。
execute as @a[tag=un.player,scores={un_drop=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function uno:input/drop
execute as @a[tag=un.player,scores={un_action=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function uno:input/submit
execute as @a[scores={un_settings=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function uno:settings/save
# 恢复物每秒补齐一次，重载或阶段切换后仍可使用。
scoreboard players add #reopen_clock un_ctx 1
execute if score #reopen_clock un_ctx matches 20.. as @a[tag=un.player] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] run function uno:input/ensure_reopen
execute if score #reopen_clock un_ctx matches 20.. run scoreboard players set #reopen_clock un_ctx 0
