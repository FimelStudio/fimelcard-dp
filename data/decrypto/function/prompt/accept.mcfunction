# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s dc_clue 0
# 使用原有提示保存入口，保留聊天、Actionbar、电报记录与后续解密。
data modify storage decrypto:input name set value {text:""}
data modify storage decrypto:input name.text set from storage decrypto:form incoming.a
function decrypto:input/save_prompt
data modify storage decrypto:input name set value {text:""}
data modify storage decrypto:input name.text set from storage decrypto:form incoming.b
function decrypto:input/save_prompt
data modify storage decrypto:input name set value {text:""}
data modify storage decrypto:input name.text set from storage decrypto:form incoming.c
function decrypto:input/save_prompt

