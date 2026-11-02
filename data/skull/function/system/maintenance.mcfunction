# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function skull:player/audience
scoreboard players set #online sk_ctx 0
execute as @a[tag=sk.audience] if entity @s[tag=ct.player] if score @s ct_id = #ctx sk_ctx run scoreboard players add #online sk_ctx 1
