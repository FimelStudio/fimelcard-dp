# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tag @a[tag=hb.hint_target] remove hb.hint_target
scoreboard players operation #target_seat hb_ctx = @a[tag=hb.action_actor,limit=1] hb_target
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #target_seat hb_ctx run tag @s add hb.hint_target
execute unless entity @a[tag=hb.hint_target,limit=1] run tellraw @a[tag=hb.action_actor,limit=1] [{text:"[花火] ",color:"light_purple"},{text:"提示目标已经失效。",color:"red"}]

