# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tag @e[tag=hb.chosen] remove hb.chosen
execute as @e[type=minecraft:marker,tag=hb.hand] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #actor_seat hb_ctx if score @s hb_slot = #slot hb_ctx run tag @s add hb.chosen
execute unless entity @e[tag=hb.chosen,limit=1] run tellraw @a[tag=hb.action_actor,limit=1] [{text:"[花火] ",color:"light_purple"},{text:"该手牌位已经不存在。",color:"red"}]

