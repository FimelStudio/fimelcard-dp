tag @e[tag=hb.chosen] remove hb.chosen
execute as @e[type=minecraft:marker,tag=hb.hand] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #actor_seat hb_ctx if score @s hb_slot = #slot hb_ctx run tag @s add hb.chosen
execute unless entity @e[tag=hb.chosen,limit=1] run tellraw @a[tag=hb.action_actor,limit=1] [{text:"[花火] ",color:"light_purple"},{text:"该手牌位已经不存在。",color:"red"}]

