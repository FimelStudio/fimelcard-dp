# uninstall-guard: begin (tools/build_uninstall.py)
execute if data storage cardtable:uninstall active run return 0
execute unless score #version ct_ctx matches 1.. run return 0
# uninstall-guard: end
# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute as @a[tag=sk.player,scores={sk_action=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] run function skull:action/handle
scoreboard players add #clock sk_ctx 1
execute if score #clock sk_ctx matches 10.. as @e[type=minecraft:marker,tag=sk.controller,scores={sk_state=1..7}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function skull:system/maintenance
execute if score #clock sk_ctx matches 10.. run scoreboard players set #clock sk_ctx 0
execute as @e[type=minecraft:marker,tag=sk.controller,scores={sk_state=7}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function skull:deal/tick
execute as @e[type=minecraft:marker,tag=sk.controller,scores={sk_state=4}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function skull:challenge/tick
execute as @e[type=minecraft:marker,tag=sk.controller,scores={sk_state=6}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function skull:round/settle_tick
execute as @e[type=minecraft:marker,tag=sk.controller,scores={sk_state=1..6}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function skull:input/scan
tag @a[tag=sk.audience] remove sk.audience
