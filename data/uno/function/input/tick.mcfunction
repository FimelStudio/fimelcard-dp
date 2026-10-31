# 仅扫描即时输入。设置窗口只在打开后启用 trigger。
execute as @a[tag=un.player,scores={un_drop=1..}] at @s run function uno:input/drop
execute as @a[tag=un.player,scores={un_action=1..}] at @s run function uno:input/submit
execute as @a[scores={un_settings=1..}] at @s run function uno:settings/save
