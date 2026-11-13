# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set #candidate sk_ctx 0
$scoreboard players set #candidate sk_ctx $(number)
execute unless score #candidate sk_ctx > @s sk_bid run return 0
execute if score #candidate sk_ctx > @s sk_total run return 0
execute if score #candidate sk_ctx < @a[tag=sk.viewer,limit=1] sk_count run return 0
$function skull:ui/button {choice:$(choice),label:"叫 $(number) 张花"}
