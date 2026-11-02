# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tag @e[tag=dc.prompt_drop] remove dc.prompt_drop
tag @s add dc.prompt_drop
execute on origin if entity @s[tag=dc.player] at @s run function decrypto:prompt/open
kill @s
tag @e[tag=dc.form_controller] remove dc.form_controller
