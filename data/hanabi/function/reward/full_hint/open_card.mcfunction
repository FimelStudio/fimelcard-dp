# 根据已保存的目标座位构造逐牌选择Dialog
scoreboard players operation #ctx_id hb_ctx = @s hb_id
tag @a[tag=hb.reward_actor] remove hb.reward_actor
execute as @a[tag=hb.player,tag=hb.reward_pending,tag=hb.turn] if score @s hb_id = #ctx_id hb_ctx run tag @s add hb.reward_actor
execute unless entity @a[tag=hb.reward_actor,limit=1] run return fail
scoreboard players set @a[tag=hb.reward_actor,limit=1] hb_action 0
scoreboard players enable @a[tag=hb.reward_actor,limit=1] hb_action
scoreboard players operation #target_seat hb_ctx = @a[tag=hb.reward_actor,limit=1] hb_target

tag @a[tag=hb.full_hint_target] remove hb.full_hint_target
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #target_seat hb_ctx run tag @s add hb.full_hint_target
execute unless entity @a[tag=hb.full_hint_target,limit=1] run return run function hanabi:reward/full_hint/open_target
execute as @a[tag=hb.full_hint_target,limit=1] at @s run function hanabi:name/resolve
data modify storage hanabi:reward full_hint_name set value {text:"",color:"aqua",bold:true,extra:[]}
data modify storage hanabi:reward full_hint_name.extra append from storage hanabi:name resolved
data modify storage hanabi:reward full_hint_cards set value {text:"",font:"card:hanabi_ui",shadow_color:0,extra:[]}
scoreboard players set #reward_card_added hb_ctx 0
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=1}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #target_seat hb_ctx run function hanabi:reward/full_hint/append_card {action:1201}
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=2}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #target_seat hb_ctx run function hanabi:reward/full_hint/append_card {action:1202}
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=3}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #target_seat hb_ctx run function hanabi:reward/full_hint/append_card {action:1203}
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=4}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #target_seat hb_ctx run function hanabi:reward/full_hint/append_card {action:1204}
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=5}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #target_seat hb_ctx run function hanabi:reward/full_hint/append_card {action:1205}
data modify storage hanabi:reward full_hint_cards.extra append value {text:"\n\n\n\n\n\n\n\n",font:"minecraft:default"}
execute as @a[tag=hb.reward_actor,limit=1] run function hanabi:input/give_reward_reopen
execute as @a[tag=hb.reward_actor,limit=1] run function hanabi:reward/full_hint/show_card with storage hanabi:reward
tag @a[tag=hb.full_hint_target] remove hb.full_hint_target
