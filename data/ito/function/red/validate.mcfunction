# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set #red_valid it_ctx 0
scoreboard players set #red_context it_ctx 0
function ito:input/context
execute unless score #valid it_ctx matches 1 run return 0
execute unless score @s ct_session = @e[tag=it.current,limit=1] ct_session run return 0
execute unless score @e[tag=it.current,limit=1] ct_state matches 1 run return 0
execute if score @e[tag=it.current,limit=1] ct_paused matches 1 run return 0
execute unless score @e[tag=it.current,limit=1] it_mode matches 1 run return 0
execute unless score @e[tag=it.current,limit=1] it_state matches 2 run return 0
execute if score @s it_done matches 1 run return 0
scoreboard players set #red_context it_ctx 1
scoreboard players set #red_cards it_ctx 0
execute as @e[tag=it.cards,scores={it_used=0,it_slot=1}] if score @s it_owner = #actor it_ctx run scoreboard players add #red_cards it_ctx 1
execute unless score #red_cards it_ctx matches 1 run return 0
execute if entity @e[tag=it.cards,scores={it_owner=1..8,it_used=0},nbt={data:{description:""}}] run return 0
scoreboard players set #red_valid it_ctx 1
