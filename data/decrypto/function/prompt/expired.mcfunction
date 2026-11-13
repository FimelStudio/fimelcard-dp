# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tellraw @s {text:'[谍报风云] 这个输入窗口已过期，请按Q重新打开紫色染料。',color:'red'}
tag @e[tag=dc.form_controller] remove dc.form_controller
data remove storage decrypto:form incoming
