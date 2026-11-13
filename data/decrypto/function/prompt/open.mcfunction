# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function decrypto:prompt/authorize
execute unless score #form_ok dc_ctx matches 1 run return 0
function decrypto:prompt/give_tool
execute as @e[tag=dc.form_controller,limit=1] run function decrypto:prompt/build
function decrypto:prompt/show with storage decrypto:form
tag @e[tag=dc.form_controller] remove dc.form_controller
