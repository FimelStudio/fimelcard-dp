# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# origin 校验保证不会收走隔壁桌或另一玩家的操作物。
scoreboard players set #ui_drop_owner un_ctx 0
execute on origin if entity @s[tag=un.dropper,tag=un.player] run scoreboard players set #ui_drop_owner un_ctx 1
execute unless score #ui_drop_owner un_ctx matches 1 run return 0
kill @s
execute as @a[tag=un.dropper,limit=1] run function uno:input/give
execute as @a[tag=un.dropper,limit=1] at @s run function uno:ui/open
