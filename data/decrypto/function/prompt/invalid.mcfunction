# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tellraw @s {text:'[谍报风云] 每条提示必须填写1至24个字符。请按Q重新打开填写。',color:'red'}
tag @e[tag=dc.form_controller] remove dc.form_controller
data remove storage decrypto:form incoming
