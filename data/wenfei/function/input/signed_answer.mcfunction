# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function wenfei:input/reject_answer
function wenfei:input/give_answer
tellraw @s {text:"[问非所答] 请勿签名，已补发空白答案册。原书可拾回查看。",color:"yellow"}
data remove entity @e[tag=wq.drop,limit=1] Item.components."minecraft:custom_data".wenfei.tool
